# syntax=docker/dockerfile:1
# MAINTAINER "Brian Scott <dev@bscott.mozmail.com>"

FROM alpine:3.6

ARG POCKETBASE_VERSION=0.7.6

RUN apk add --no-cache \
    ca-certificates \
    unzip \
    wget \
    zip \
    zlib-dev

ADD https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip /tmp/pocketbase.zip
RUN unzip /tmp/pocketbase.zip -d /usr/local/bin/
RUN chmod +x /usr/local/bin/pocketbase

EXPOSE 8090

WORKDIR /app

VOLUME /app/pb_data
VOLUME /app/pb_public

CMD [ "/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090" ]
