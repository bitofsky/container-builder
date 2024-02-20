FROM node:18.12.0-slim

ENV DEBIAN_FRONTEND noninteractive
ENV PNPM_VERSION 7.29.0
ENV TURBO_VERSION 1.8.3
ENV TSX_VERSION 3.12.5

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        ca-certificates \
        build-essential \
        wget \
        jq \
        patch \
        python3 \
        curl \
        unzip \
        git && \
    apt-get clean

# install awscli v2. see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.15.21.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp/ \
    && /tmp/aws/install \
    && rm /tmp/awscliv2.zip \
    && rm -rf /tmp/aws

# install node packages
RUN npm i -g pnpm@${PNPM_VERSION} turbo@${TURBO_VERSION} tsx@${TSX_VERSION}

# install genuinetools/img for containerize without privileged
RUN curl -fSL "https://github.com/genuinetools/img/releases/download/v0.5.11/img-linux-amd64" -o "/usr/bin/img" \
	&& echo "cc9bf08794353ef57b400d32cd1065765253166b0a09fba360d927cfbd158088  /usr/bin/img" | sha256sum -c - \
	&& chmod a+x "/usr/bin/img"

RUN curl -L "https://github.com/moby/buildkit/releases/download/v0.11.4/buildkit-v0.11.4.linux-amd64.tar.gz" -o /tmp/buildkit.tar.gz \
    && mkdir -p /tmp/buildkit \
    && tar -C /tmp/buildkit -xzf /tmp/buildkit.tar.gz \
    && mv /tmp/buildkit/bin/buildctl /usr/bin/buildctl \
    && chmod a+x /usr/bin/buildctl \
    && rm -rf /tmp/buildkit \
    && rm /tmp/buildkit.tar.gz

# install kubectl
RUN curl -L "https://dl.k8s.io/release/v1.20.15/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.20"
RUN curl -L "https://dl.k8s.io/release/v1.21.14/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.21"
RUN curl -L "https://dl.k8s.io/release/v1.22.12/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.22"
RUN curl -L "https://dl.k8s.io/release/v1.23.9/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.23"
RUN curl -L "https://dl.k8s.io/release/v1.24.3/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.24"
RUN curl -L "https://dl.k8s.io/release/v1.25.7/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.25"
RUN curl -L "https://dl.k8s.io/release/v1.26.2/bin/linux/amd64/kubectl" -o "/usr/bin/kubectl-v1.26" && chmod a+x /usr/bin/kubectl*

RUN ln -s /usr/bin/kubectl-v1.24 /usr/bin/kubectl

# install golang
COPY --from=golang:1.20.2 /usr/local/go/ /usr/local/go/
ENV GOPATH /go
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN ln -s /bin/bash /usr/bin/bash && \
    ln -s /bin/sh /usr/bin/sh

ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/bin:${PATH}
