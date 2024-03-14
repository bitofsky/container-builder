FROM node:18.12.0-slim as builder

ENV DEBIAN_FRONTEND noninteractive
ENV PNPM_VERSION 8.6.12
ENV AWS_CLI 2.15.28

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        python3 \
        curl \
        unzip && \
    apt-get clean

# install awscli v2. see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI}.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp/ \
    && /tmp/aws/install \
    && rm /tmp/awscliv2.zip \
    && rm -rf /tmp/aws

# install node packages
RUN npm i -g pnpm@${PNPM_VERSION}

RUN curl -L "https://github.com/moby/buildkit/releases/download/v0.13.0/buildkit-v0.13.0.linux-amd64.tar.gz" -o /tmp/buildkit.tar.gz \
    && mkdir -p /tmp/buildkit \
    && tar -C /tmp/buildkit -xzf /tmp/buildkit.tar.gz \
    && mv /tmp/buildkit/bin/buildctl /usr/bin/buildctl \
    && chmod a+x /usr/bin/buildctl \
    && rm -rf /tmp/buildkit \
    && rm /tmp/buildkit.tar.gz

# install kubectl
RUN curl -L "https://dl.k8s.io/release/v1.27.11/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.27"
RUN curl -L "https://dl.k8s.io/release/v1.28.7/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.28"
RUN curl -L "https://dl.k8s.io/release/v1.29.2/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.29" && chmod a+x /usr/bin/kubectl*

RUN ln -s /usr/bin/kubectl-v1.29 /usr/bin/kubectl

# runner
FROM node:18.12.0-slim as runner
COPY --link --from=builder /usr /usr

# install golang
COPY --link --from=golang:1.20.2 /usr/local/go/ /usr/local/go/
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/bin:${PATH}

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
    ln -s /bin/bash /usr/bin/bash && \
    ln -s /bin/sh /usr/bin/sh && \
    npm i -g pnpm@${PNPM_VERSION}

