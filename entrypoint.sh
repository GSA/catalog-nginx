#!/bin/bash

# If environment variables aren't set, fallback to legacy link provided
# environment variables
export APP_HOST="${APP_HOST:-$APP_PORT_80_TCP_ADDR}"
export APP_PORT="${APP_PORT:-$APP_PORT_80_TCP_PORT}"
export PYCSW_HOST="${PYCSW_HOST:-$PYCSW_PORT_80_TCP_ADDR}"
export PYCSW_PORT="${PYCSW_PORT:-$PYCSW_PORT_80_TCP_PORT}"

function wait-for-dependencies () {
  local host="$1"
  local port="$2"
  while ! nc -w 1 -z "$host" "$port"; do
    sleep 1;
  done
}

# Inject environment into configs
envsubst '$APP_HOST $APP_PORT $PYCSW_HOST $PYCSW_PORT' < /my_init.d/nginx.conf.template > /etc/nginx/nginx.conf

# wait for all services to start-up
if [ "$1" = '--wait-for-dependencies' ]; then
    echo -n Waiting for app...
    wait-for-dependencies "$APP_HOST" "$APP_PORT"
    echo "done"

    echo -n Waiting for pycsw...
    wait-for-dependencies "$PYCSW_HOST" "$PYCSW_PORT"
    echo "done"
fi

exec "$@"
