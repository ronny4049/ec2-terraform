# Use a lightweight Alpine Linux base image
FROM alpine:3.18

# Install necessary packages
RUN apk add --no-cache \
    curl \
    unzip \
    git \
    python3 \
    py3-pip \
    openssh-client \
    gnupg \
    bash

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Install Terraform
ARG TERRAFORM_VERSION=1.5.7
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    chmod +x /usr/local/bin/terraform

# Install terraform-docs (optional)
RUN curl -LO https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz && \
    tar -xzf terraform-docs-v0.16.0-linux-amd64.tar.gz && \
    chmod +x terraform-docs && \
    mv terraform-docs /usr/local/bin/ && \
    rm terraform-docs-v0.16.0-linux-amd64.tar.gz

# Install tflint (optional)
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Clean up
RUN rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
