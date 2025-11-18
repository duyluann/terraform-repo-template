FROM duyluann/terraform-toolkit:latest

# Switch to root for system modifications
USER root

# Set bash as the default shell for better compatibility with devcontainer features
SHELL ["/bin/bash", "-c"]

# Configure bash as default shell and create symlink
# Most images already have bash, we just need to ensure it's the default
RUN ln -sf /bin/bash /bin/sh && \
    if [ -f /etc/passwd ]; then \
      sed -i 's|:/bin/sh$|:/bin/bash|g' /etc/passwd || true; \
    fi

# Set default shell environment
ENV SHELL=/bin/bash

# Install dependencies for cloud CLIs
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    gnupg \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Azure CLI (if not already installed)
RUN if ! command -v az &> /dev/null; then \
        echo "Installing Azure CLI..." && \
        curl -sL https://aka.ms/InstallAzureCLIDeb | bash; \
    else \
        echo "Azure CLI already installed, skipping..."; \
    fi

# Install Google Cloud SDK (if not already installed)
RUN if ! command -v gcloud &> /dev/null; then \
        echo "Installing Google Cloud SDK..." && \
        echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
        tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
        gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
        apt-get update && apt-get install -y google-cloud-cli && \
        rm -rf /var/lib/apt/lists/*; \
    else \
        echo "Google Cloud SDK already installed, skipping..."; \
    fi

# Create credential directories for multi-cloud support
RUN mkdir -p /home/tf-user/.aws \
    && mkdir -p /home/tf-user/.azure \
    && mkdir -p /home/tf-user/.config/gcloud \
    && chown -R tf-user:tf-user /home/tf-user/.aws \
    && chown -R tf-user:tf-user /home/tf-user/.azure \
    && chown -R tf-user:tf-user /home/tf-user/.config

# Switch back to the non-root user for security
USER tf-user
