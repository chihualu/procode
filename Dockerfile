# Dockerfile for OpenCode image
# 1️⃣ Build Stage – include Java 21, Maven, Node.js, git and OpenCode CLI
FROM ubuntu:22.04 AS build
ENV DEBIAN_FRONTEND=noninteractive
# Install core tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl gnupg ca-certificates \
        git \
        openjdk-21-jdk \
        python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*
# Node.js 20 via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*
# Maven 3.9.12 (latest stable)
RUN mkdir -p /opt/maven && \
    curl -fsSL https://dlcdn.apache.org/maven/maven-3/3.9.12/binaries/apache-maven-3.9.12-bin.tar.gz | \
    tar -xz -C /opt/maven --strip-components=1 && \
    ln -s /opt/maven/bin/mvn /usr/local/bin/mvn
ENV PATH=/opt/maven/bin:$PATH
# OpenCode CLI install
RUN curl -fsSL https://opencode.ai/install | bash
ENV OPENCODE_HOME=/root/.opencode
ENV PATH=$PATH:$OPENCODE_HOME/bin
# Copy the supplied OpenCode config to the global config directory
COPY opencode.json /root/.config/opencode/opencode.json
# Runtime Stage – lightweight OpenJDK 21 runtime (JRE)
FROM azul/zulu-openjdk:21-jre
# Copy build artifacts
COPY --from=build /opt/maven /opt/maven
COPY --from=build /root/.opencode /root/.opencode
COPY --from=build /usr/local/bin/mvn /usr/local/bin/mvn
COPY --from=build /usr/bin/node /usr/bin/node
COPY --from=build /usr/bin/npm /usr/bin/npm
COPY --from=build /root/.config/opencode /root/.config/opencode
# Set environment variables
ENV PATH=/opt/maven/bin:$PATH
ENV OPENCODE_HOME=/root/.opencode
ENV PATH=$PATH:$OPENCODE_HOME/bin
# Set working directory
WORKDIR /workspace
# Default entrypoint is the OpenCode CLI
ENTRYPOINT ["opencode"]