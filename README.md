# OpenCode Docker Image

![GitHub Actions Workflow Status](https://github.com/chihualu/opencode-image/actions/workflows/publish.yml/badge.svg)
![License](https://img.shields.io/github/license/chihualu/opencode-image)

This project provides a customized Docker image for **OpenCode**, extending the official `ghcr.io/anomalyco/opencode` image. It pre-configures the environment with a custom `opencode.json` suitable for connecting to OpenAI-compatible APIs (like vLLM).

## Features

*   **Base Image**: Built on top of `ghcr.io/anomalyco/opencode:latest`.
*   **Pre-configured**: Includes `opencode.json` injected into `/etc/opencode/`.
*   **Environment Ready**: configured to use `API_BASEURL` and `API_KEY` environment variables for flexible deployment.

## Getting Started

### Prerequisites

*   Docker installed on your machine.
*   Access to an OpenAI-compatible API endpoint (e.g., vLLM, Ollama, etc.).

### Usage

You can pull the pre-built image from the GitHub Container Registry:

```bash
docker pull ghcr.io/chihualu/opencode:latest
```

### Running the Container

To run the container, you must provide the `API_BASEURL` and `API_KEY` environment variables.

```bash
docker run -it --rm \
  -p 3000:3000 \
  -e API_BASEURL="https://your-api-endpoint.com/v1" \
  -e API_KEY="your-secret-api-key" \
  ghcr.io/chihualu/opencode:latest
```

*   **`-p 3000:3000`**: Maps port 3000 of the container to port 3000 on your host.
*   **`-e API_BASEURL`**: The base URL of your LLM provider.
*   **`-e API_KEY`**: Your API key for the LLM provider.

## Configuration

The image uses a custom `opencode.json` located at `/etc/opencode/opencode.json`.
The application is configured to look for this file via the `OPENCODE_CONFIG` environment variable.

### Default Provider
*   **Provider**: `vllm` (via `@ai-sdk/openai-compatible`)
*   **Default Model**: `gpt-oss`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
