FROM node:20.12.2-slim

ENV DEBIAN_FRONTEND noninteractive
ENV PNPM_VERSION 9.0.2
ENV TURBO_VERSION 1.13.2
ENV TSX_VERSION 4.7.2
ENV TS_NODE 10.9.2
ENV SWC_CORE 1.4.15
ENV AWS_CLI 2.15.39
ENV BUILDKIT_VERSION 0.13.1

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
RUN curl -L "https://dl.k8s.io/release/v1.27.12/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.27" \
 && curl -L "https://dl.k8s.io/release/v1.28.8/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.28" \
 && curl -L "https://dl.k8s.io/release/v1.29.3/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.29" \
 && curl -L "https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.30" \
 && chmod a+x /usr/bin/kubectl*

RUN ln -s /usr/bin/kubectl-v1.24 /usr/bin/kubectl

# install golang
COPY --from=golang:1.22.0 /usr/local/go/ /usr/local/go/
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/bin:${PATH}

# install amazon-ecr-credential-helper
RUN curl -L "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.8.0/linux-amd64/docker-credential-ecr-login" -o "/usr/bin/docker-credential-ecr-login" \
 && chmod a+x /usr/bin/docker-credential-ecr-login

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

