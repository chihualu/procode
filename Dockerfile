# Base image
FROM node:20-slim

# Install git and other dependencies if needed
RUN apt-get update && apt-get install -y git gettext-base && rm -rf /var/lib/apt/lists/*

# Install llxprt-code globally
RUN npm install -g @vybestack/llxprt-code

# Create configuration directory
RUN mkdir -p /root/.llxprt

# Copy configuration files
COPY settings.json /root/.llxprt/settings.json
COPY welcomeConfig.json /root/.llxprt/welcomeConfig.json
COPY profiles/ /root/.llxprt/profiles/
RUN mkdir -p /root/.llxprt/prompts/providers/openai/
COPY core.md /root/.llxprt/prompts/providers/openai/core.md

# Create working directory
WORKDIR /workspace

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command (empty, can be overridden)
CMD []