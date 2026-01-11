#!/bin/bash

set -e;


# USER MANAGEMENT
if rabbitmqctl list_users | awk '{print $1}' | grep -qx admin; then
  echo "admin exists → updating password"
  rabbitmqctl change_password admin "$RABBITMQ_ADMIN_PASSWORD"
else
  echo "Creating user admin"
  rabbitmqctl add_user admin "$RABBITMQ_ADMIN_PASSWORD"
fi

rabbitmqctl set_user_tags admin administrator

rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

rabbitmqctl delete_user guest || true



