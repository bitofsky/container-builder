FROM alpine:3.22

ENV AWS_CLI=2.27.19

RUN apk update \
 && apk add --no-cache \
    ca-certificates \
    build-base \
    wget \
    jq \
    patch \
    curl \
    unzip

# install awscli v2. see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI}.zip" -o /tmp/awscliv2.zip \
 && unzip /tmp/awscliv2.zip -d /tmp/ \
 && /tmp/aws/install \
 && rm /tmp/awscliv2.zip \
 && rm -rf /tmp/aws

# install amazon-ecr-credential-helper
RUN curl -L "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.9.1/linux-amd64/docker-credential-ecr-login" -o "/usr/bin/docker-credential-ecr-login" \
 && chmod a+x /usr/bin/docker-credential-ecr-login


COPY script /script 