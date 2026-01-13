# OpenCode Docker Environment

![GitHub Actions Workflow Status](https://github.com/chihualu/opencode/actions/workflows/publish.yml/badge.svg)
![License](https://img.shields.io/github/license/chihualu/opencode)

This project provides a ready-to-use Docker environment for the **OpenCode CLI**. It comes pre-installed with essential development tools (Java, Node.js, Python, Maven) and is configured to interface with local LLMs via Ollama.

## Features

*   **OpenCode CLI**: Pre-installed and configured.
*   **Toolchain**:
    *   Java 21 (Zulu OpenJDK)
    *   Maven 3.9.12
    *   Node.js 20
    *   Python 3
*   **Ollama Integration**: Configured to connect to an Ollama instance via the `OLLAMA_BASEURL` environment variable.

## Getting Started

### Prerequisites

*   Docker installed on your machine.
*   An Ollama instance running (locally or remotely).

### Running the Container

You can pull the pre-built image from the GitHub Container Registry:

```bash
docker pull ghcr.io/chihualu/opencode:latest
```

Run the container, connecting it to your local Ollama instance:

```bash
docker run -it --rm \
  -e OLLAMA_BASEURL=http://host.docker.internal:11434/v1 \
  -v $(pwd):/workspace \
  ghcr.io/chihualu/opencode:latest
```

*   **`-e OLLAMA_BASEURL=...`**: URL to your Ollama API.
    *   If running Ollama on the same machine (Windows/Mac), use `http://host.docker.internal:11434/v1`.
    *   If on Linux, use `http://localhost:11434/v1` with `--network="host"`, or the host's actual IP.
    *   **Custom Server**: `http://ai.provision.com.tw:11434/v1`
*   **`-v $(pwd):/workspace`**: Mounts your current directory to `/workspace` inside the container.

### Building Locally

If you want to modify the image:

```bash
docker build -t opencode .
```

## Configuration

The image includes an `opencode.json` configuration file located at `~/.config/opencode/opencode.json`. It is set up to use the `ollama` provider.

Supported models in default config:
*   `qwen2.5-coder:7b`
*   `gpt-oss:20b`
*   `qwen3-coder:30b`

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
