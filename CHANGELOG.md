## 2025-10

* Upgrade turbo: 2.5.3 -> 2.5.8

## 2025-05

* Upgrade Node.js base image: 20.12.2 (slim) → 24.0.2 (slim)
* Upgrade pnpm: 9.0.2 → 10.11.0
* Upgrade turbo: 1.13.2 → 2.5.3
* Upgrade tsx: 4.7.2 → 4.19.4
* Upgrade @swc/core: 1.4.15 → 1.11.24
* Upgrade AWS CLI: 2.15.39 → 2.27.19
* Upgrade BuildKit (buildctl): 0.13.1 → 0.21.1
* Upgrade amazon-ecr-credential-helper: 0.8.0 → 0.9.1
* Update kubectl versions: add 1.30.13, 1.31.9, 1.32.5; remove 1.27.12, 1.28.8, 1.29.3, 1.30.0
* Set default kubectl symlink to v1.32
* Continue to install Go 1.22.0 from the official golang image

## 5.1.0-20221102 (2022-11-02)

* amazonlinux base image change to 2022 from 2 ([343f6eb](https://github.com/bitofsky/bazel-builder/commit/343f6eb))
* nodejs upgrade to LTS 18 ([1ea9c59](https://github.com/bitofsky/bazel-builder/commit/1ea9c59))
* update cosign ([9e3e205](https://github.com/bitofsky/bazel-builder/commit/9e3e205))
* Update docker-publish.yml ([fc3a2cb](https://github.com/bitofsky/bazel-builder/commit/fc3a2cb))
* Update docker-publish.yml ([1eac4ad](https://github.com/bitofsky/bazel-builder/commit/1eac4ad))
* Update docker-publish.yml ([61fd32d](https://github.com/bitofsky/bazel-builder/commit/61fd32d))
* add: kubectl ([c9fba96](https://github.com/bitofsky/bazel-builder/commit/c9fba96))



## 5.1.0-img (2022-06-17)

* fix ([4ace1c2](https://github.com/bitofsky/bazel-builder/commit/4ace1c2))
* add: checksum ([fb8d15a](https://github.com/bitofsky/bazel-builder/commit/fb8d15a))
* doc: add genuinetools/img ([69f6409](https://github.com/bitofsky/bazel-builder/commit/69f6409))
* kaniko: remove ([cf86b7d](https://github.com/bitofsky/bazel-builder/commit/cf86b7d))



## 5.1.0-kaniko (2022-06-15)

* update: document ([1c1eeef](https://github.com/bitofsky/bazel-builder/commit/1c1eeef))
* add: kaniko binary ([dcb33f6](https://github.com/bitofsky/bazel-builder/commit/dcb33f6))
* init ([82e7b97](https://github.com/bitofsky/bazel-builder/commit/82e7b97))
* update bazel to 5.1.0 ([a491158](https://github.com/bitofsky/bazel-builder/commit/a491158))
* Update Dockerfile ([b85b645](https://github.com/bitofsky/bazel-builder/commit/b85b645))
* Update Dockerfile ([1bf2514](https://github.com/bitofsky/bazel-builder/commit/1bf2514))



