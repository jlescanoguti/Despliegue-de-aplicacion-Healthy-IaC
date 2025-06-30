FROM jenkins/jenkins:2.504.2-jdk17

USER root

# Instalar herramientas esenciales
RUN apt-get update && apt-get install -y \
    git \
    maven \
    curl \
    python3 \
    python3-pip \
    docker.io \
    awscli \
    gnupg \
    software-properties-common \
    lsb-release \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" > /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y terraform \
    && rm -rf /var/lib/apt/lists/*

# Configurar Docker
RUN usermod -aG docker jenkins

# Instalar plugins directamente sin script externo
RUN jenkins-plugin-cli --plugins \
    git \
    workflow-aggregator \
    pipeline-aws \
    docker-plugin \
    blueocean \
    ssh-agent \
    aws-credentials \
    terraform

# Copiar configuración YAML
COPY jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml

USER jenkins
