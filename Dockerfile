FROM amazonlinux:2

ENV NODE_PACKAGE https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz
ENV NODE_PATH /opt/node

ENV YARN_VERSION 1.22.4
ENV BAZEL_PACKAGE https://github.com/bazelbuild/bazel/releases/download/4.0.0/bazel-4.0.0-installer-linux-x86_64.sh

ENV PATH=${PATH}:${NODE_PATH}/bin

# install docker
RUN amazon-linux-extras install -y docker && yum clean all

# install need package
RUN yum install -y gcc gcc-c++ make tar xz which unzip java git patch awscli jq python3 && yum clean all

# install bazel
RUN curl -L -o bazel.sh ${BAZEL_PACKAGE} && chmod +x bazel.sh && ./bazel.sh && rm bazel.sh && echo -e 'cat >> ~/.bashrc <<EOF\nif [ -f "$HOME/.bazel/bin/bazel-complete.bash" ]; then\n . $HOME/.bazel/bin/bazel-complete.bash\nfi\nEOF\ntrue' | bash

# install node
RUN mkdir -p ${NODE_PATH} && curl ${NODE_PACKAGE} | tar xvfJ - -C ${NODE_PATH} --strip-components=1 && npm i -g yarn@${YARN_VERSION}

