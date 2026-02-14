# Use the official Jenkins LTS image
FROM jenkins/jenkins:lts

USER root

# 1. Install prerequisites
RUN apt-get update && apt-get install -y \
    lsb-release \
    python3 \
    python3-pip \
    python3-venv \
    ca-certificates \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# 2. Robust Docker CLI Installation
# We download the key to a temporary file first to ensure it's valid before de-armoring
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /tmp/docker.key && \
    gpg --dearmor < /tmp/docker.key > /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y docker-ce-cli && \
    rm /tmp/docker.key && \
    rm -rf /var/lib/apt/lists/*

# 3. Add jenkins user to docker group for socket access
RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins