# OpenCode Docker Environment

This project defines a Docker image capable of running the [OpenCode CLI](https://opencode.ai) within a pre-configured development environment. It is designed to be a self-contained environment for AI-assisted coding tasks, specifically configured to interface with local LLMs via Ollama.

## Project Overview

The core of this project is the `Dockerfile`, which builds a lightweight runtime image containing:
*   **OpenCode CLI**: The primary tool for AI interactions.
*   **Development Tools**:
    *   Java 21 (OpenJDK / Zulu JRE)
    *   Maven 3.9.12
    *   Node.js 20 & npm
    *   Python 3 & pip
    *   Git

The environment is pre-loaded with an `opencode.json` configuration that sets up **Ollama** as the default model provider.

## Key Files

*   **`Dockerfile`**: A multi-stage Docker build.
    *   *Build Stage*: Installs all dependencies on Ubuntu 22.04.
    *   *Runtime Stage*: Copies the necessary binaries and configuration to a slim `azul/zulu-openjdk:21-jre` image.
*   **`opencode.json`**: The OpenCode configuration file. It explicitly configures the `ollama` provider and defines models like `qwen2.5-coder:7b`, `gpt-oss:20b`, and `qwen3-coder:30b`. It expects the `OLLAMA_BASEURL` environment variable to be set at runtime.

## Usage

### Building the Image

To build the Docker image, run the following command in the directory containing the Dockerfile:

```bash
docker build -t opencode .
```

### Running the Container

When running the container, you usually need to provide the `OLLAMA_BASEURL` so the OpenCode CLI can communicate with your local Ollama instance (or a remote one).

**Example:**

```bash
docker run -it --rm \
  -e OLLAMA_BASEURL=http://host.docker.internal:11434/v1 \
  -v $(pwd):/workspace \
  opencode
```

*   `-e OLLAMA_BASEURL=...`: Points OpenCode to the API endpoint of your LLM provider.
*   `-v $(pwd):/workspace`: Mounts your current local directory to `/workspace` inside the container, allowing OpenCode to work on your local files.
*   The default entrypoint is `opencode`, so you can pass arguments directly (e.g., adding `help` at the end of the command).

## Configuration Details

The included `opencode.json` is copied to `/root/.config/opencode/opencode.json` inside the container. It is configured to use the `@ai-sdk/openai-compatible` npm package to talk to Ollama.

**Defined Models:**
*   `qwen2.5-coder:7b`
*   `gpt-oss:20b`
*   `qwen3-coder:30b`
