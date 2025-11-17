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

# Switch back to the non-root user for security
USER tf-user
