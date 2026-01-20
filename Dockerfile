# Base image
FROM ghcr.io/anomalyco/opencode:latest

# Create a directory for the configuration file
# Using a standard location like /etc/opencode is a good practice
RUN mkdir -p /etc/opencode

# Copy the local opencode.json into the container
COPY opencode.json /etc/opencode/opencode.json

# Set the OPENCODE_CONFIG environment variable
# This tells the application specifically where to look for the configuration,
# overriding default search paths.
ENV OPENCODE_CONFIG="/etc/opencode/opencode.json"
