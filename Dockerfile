FROM alpine:3.22

ENV AWS_CLI=2.27.25-r0

RUN apk update \
 && apk add --no-cache \
    ca-certificates \
    build-base \
    bash \
    wget \
    jq \
    patch \
    curl \
    unzip \
    aws-cli=${AWS_CLI} 

COPY script /script
