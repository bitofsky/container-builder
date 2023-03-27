### README.md
Container Image for Node.js and Golang Development
==================================================
Includes:
- Node.js 18.12.0
- PNPM 7.29.0
- Turbo 1.8.3
- TSX 3.12.5
- Golang 1.20.2
- Docker base image: node:18.12.0-slim
- Additional tools: software-properties-common, ca-certificates, build-essential, wget, jq, patch, awscli, python3, curl, git
- genuinetools/img v0.5.11
- Moby BuildKit v0.11.4
- kubectl v1.20 ~ v1.26 (default v1.24)

This container image is designed for both Node.js and Golang development. It includes a variety of packages and tools that will streamline your workflow and improve productivity.