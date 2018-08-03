# catalog-nginx
[See Main Project](https://github.com/GSA/catalog-app)

<a href="http://drone.datagov.us/GSA/catalog-nginx"><img src="http://drone.datagov.us/api/badges/GSA/catalog-nginx/status.svg" /></a>

This container proxies to the catalog-app (app) and pycsw. The container can't
run on its own because the backing service containers need to be running. For
development and testing, we create a backend container that returns some simple
data.

## Usage

Add this to your docker-compose:

```yaml
services:
  nginx:
    environment:
      APP_HOST: app
      APP_PORT: <app-port>
      PYCSW_HOST: pycws
      PYCSW_PORT: <pycws-port>
    depends_on:
      - app
      - pycsw
```


## Development

Build the container.

    $ make build

Start the container. _Note: nginx doesn't produce any output on startup._

    $ make up

Run the tests.

    $ make test

Open a shell in the nginx container for debugging.

    $ docker-compose exec nginx bash

Stop the containers and cleanup their volumes.

    $ make clean
