FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl

COPY ./test.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/test.sh

CMD ["test.sh"]
