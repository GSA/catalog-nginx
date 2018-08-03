.PHONY: all build down test up

all: build

build:
	docker-compose build

clean:
	docker-compose down

up:
	docker-compose up nginx

test:
	docker-compose up --abort-on-container-exit
