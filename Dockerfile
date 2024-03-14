FROM node:18.12.0-slim as builder

ENV DEBIAN_FRONTEND noninteractive
ENV PNPM_VERSION 8.6.12
ENV AWS_CLI 2.15.28

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install awscli v2. see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI}.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp/ \
    && /tmp/aws/install \
    && rm /tmp/awscliv2.zip \
    && rm -rf /tmp/aws

RUN curl -L "https://github.com/moby/buildkit/releases/download/v0.13.0/buildkit-v0.13.0.linux-amd64.tar.gz" -o /tmp/buildkit.tar.gz \
    && mkdir -p /tmp/buildkit \
    && tar -C /tmp/buildkit -xzf /tmp/buildkit.tar.gz \
    && mv /tmp/buildkit/bin/buildctl /usr/bin/buildctl \
    && chmod a+x /usr/bin/buildctl \
    && rm -rf /tmp/buildkit \
    && rm /tmp/buildkit.tar.gz

# install kubectl
COPY --link --from=bitnami/kubectl:1.29.2 /opt/bitnami/kubectl/bin/kubectl /usr/bin/kubectl

# install golang
COPY --link --from=golang:1.20.2 /usr/local/go/ /usr/local/go/
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/bin:${PATH}

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
    ln -s /bin/bash /usr/bin/bash && \
    ln -s /bin/sh /usr/bin/sh && \
    npm i -g pnpm@${PNPM_VERSION}
