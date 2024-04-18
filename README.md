# Docker Image Specifications

This document provides detailed information about the tools and packages included in our Docker image, ensuring a robust environment for development.

## Base Image

- **Node.js**: 20.12.2 (Slim version)

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

- **AWS CLI**: Version 2.15.39
- **pnpm**: Version 9.0.2
- **turbo**: Version 1.13.2
- **tsx**: Version 4.7.2
- **ts-node**: Version 10.9.2
- **@swc/core**: Version 1.4.15
- **buildctl** from BuildKit: Version 0.13.1

### Kubernetes Control Binaries

Multiple versions of **kubectl** are available to suit different cluster versions:

- Version 1.27.12
- Version 1.28.8
- Version 1.29.3
- Version 1.30.0

### Go Programming Language

- **Go**: Version 1.20.2 installed from the official golang image.

## Environmental Variables

Configured for optimal performance and non-interactive installations:

- `DEBIAN_FRONTEND`: `noninteractive`
- `PNPM_VERSION`: `9.0.2`
- `TURBO_VERSION`: `1.13.2`
- `TSX_VERSION`: `4.7.2`
- `TS_NODE`: `10.9.2`
- `SWC_CORE`: `1.4.15`
- `AWS_CLI`: `2.15.39`
- `BUILDKIT_VERSION`: `0.13.1`

## Paths

- **GOPATH**: `/go`
- Extensive PATH configuration ensures easy access to installed binaries across the system.

This Docker image is meticulously crafted to cater to the diverse needs of developers, encompassing a wide range of tools and languages for modern software development.
