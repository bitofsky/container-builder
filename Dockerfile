FROM node:24.0.2-slim

ENV DEBIAN_FRONTEND noninteractive
ENV PNPM_VERSION 10.11.0
ENV TURBO_VERSION 2.5.3
ENV TSX_VERSION 4.19.4
ENV TS_NODE 10.9.2
ENV SWC_CORE 1.11.24
ENV AWS_CLI 2.27.19
ENV BUILDKIT_VERSION 0.21.1

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    build-essential \
    wget \
    jq \
    patch \
    python3 \
    curl \
    unzip \
    git \
 && apt-get clean

# install awscli v2. see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI}.zip" -o /tmp/awscliv2.zip \
 && unzip /tmp/awscliv2.zip -d /tmp/ \
 && /tmp/aws/install \
 && rm /tmp/awscliv2.zip \
 && rm -rf /tmp/aws

# install node packages
RUN npm i -g pnpm@${PNPM_VERSION} turbo@${TURBO_VERSION} tsx@${TSX_VERSION} ts-node@${TS_NODE} @swc/core@${SWC_CORE}

RUN curl -L "https://github.com/moby/buildkit/releases/download/v${BUILDKIT_VERSION}/buildkit-v${BUILDKIT_VERSION}.linux-amd64.tar.gz" -o /tmp/buildkit.tar.gz \
 && mkdir -p /tmp/buildkit \
 && tar -C /tmp/buildkit -xzf /tmp/buildkit.tar.gz \
 && mv /tmp/buildkit/bin/buildctl /usr/bin/buildctl \
 && chmod a+x /usr/bin/buildctl \
 && rm -rf /tmp/buildkit \
 && rm /tmp/buildkit.tar.gz

# install kubectl
RUN curl -L "https://dl.k8s.io/release/v1.30.13/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.30" \
 && curl -L "https://dl.k8s.io/release/v1.31.9/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.31" \
 && curl -L "https://dl.k8s.io/release/v1.32.5/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.32" \
 && chmod a+x /usr/bin/kubectl*

RUN ln -s /usr/bin/kubectl-v1.32 /usr/bin/kubectl

# install golang
COPY --from=golang:1.24.3 /usr/local/go/ /usr/local/go/
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/bin:${PATH}

# install amazon-ecr-credential-helper
RUN curl -L "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.9.1/linux-amd64/docker-credential-ecr-login" -o "/usr/bin/docker-credential-ecr-login" \
 && chmod a+x /usr/bin/docker-credential-ecr-login

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

