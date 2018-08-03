FROM nginx:stable

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y netcat

COPY nginx.conf.template /my_init.d/

COPY entrypoint.sh /entrypoint.sh

COPY start.sh /usr/local/bin/

ENTRYPOINT ["/entrypoint.sh"]

CMD ["start.sh"]
