# Docker Image Specifications

This document details the versions of various packages and tools included in our Docker image.

## Base Image

- **Node.js**: 20.12.2 (Slim version)

## Installed Packages

The following packages and tools are installed:

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

### Kubernetes Control Binaries

- **kubectl**:
  - Version 1.27.12
  - Version 1.28.8
  - Version 1.29.3
  - Version 1.30.0

### Additional Tools

- **buildctl** from BuildKit Version 0.11.4

### Go Programming Language

- **Go**: Version 1.20.2

## Paths

- **GOPATH**: `/go`
- All Go binaries are added to PATH, ensuring easy execution of Go applications.

## Environmental Variables

- `DEBIAN_FRONTEND`: `noninteractive`
- System paths are configured to prioritize user-installed binaries.

This Docker image is configured to provide a comprehensive development environment with multiple tools and languages, catering to various development needs.
