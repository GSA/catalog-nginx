#!/bin/bash


# wait for all services to start-up
if [ "$1" = '--wait-for-dependencies' ]; then
    sh -c "while ! nc -w 1 -z $APP_PORT_5000_TCP_ADDR $APP_PORT_5000_TCP_PORT; do echo 'Waiting for app...'; sleep 2; done"
    echo "app is up"
    sh -c "while ! nc -w 1 -z $PYCSW_PORT_80_TCP_ADDR $PYCSW_PORT_80_TCP_PORT; do echo 'Waiting for pycsw...'; sleep 2; done"
    echo "pycsw is up"
fi

# start nginx
nginx -g "daemon off;"
