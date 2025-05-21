# Docker Image Specifications

This document provides detailed information about the tools and packages included in our Docker image, ensuring a robust environment for development.

## Base Image

- **Node.js**: 24.0.2 (Slim version)

## Installed Packages

Below is a list of the essential packages and tools installed in this Docker image:

### System Tools

- **software-properties-common**
- **ca-certificates**
- **build-essential**
- **wget**
- **jq**
- **patch**
- **python3**
- **curl**
- **unzip**
- **git**

### Programming Languages and CLI Tools

- **AWS CLI**: Version 2.27.19
- **amazon-ecr-credential-helper**: Version 0.9.1
- **pnpm**: Version 10.11.0
- **turbo**: Version 2.5.3
- **tsx**: Version 4.19.4
- **ts-node**: Version 10.9.2
- **@swc/core**: Version 1.11.24
- **buildctl** from BuildKit: Version 0.21.1

### Kubernetes Control Binaries

Multiple versions of **kubectl** are available to suit different cluster versions:

- Version 1.30.13
- Version 1.31.9
- Version 1.32.5

The default `kubectl` symlink points to v1.32.

### Go Programming Language

- **Go**: Version 1.22.0 installed from the official golang image.

## Environmental Variables

Configured for optimal performance and non-interactive installations:

- `DEBIAN_FRONTEND`: `noninteractive`
- `PNPM_VERSION`: `10.11.0`
- `TURBO_VERSION`: `2.5.3`
- `TSX_VERSION`: `4.19.4`
- `TS_NODE`: `10.9.2`
- `SWC_CORE`: `1.11.24`
- `AWS_CLI`: `2.27.19`
- `BUILDKIT_VERSION`: `0.21.1`

## Paths

- **GOPATH**: `/go`
- Extensive PATH configuration ensures easy access to installed binaries across the system.

This Docker image is meticulously crafted to cater to the diverse needs of developers, encompassing a wide range of tools and languages for modern software development.
