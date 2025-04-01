# Use a lightweight Alpine Linux base image
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache \
    curl \
    unzip \
    wget

# Install Terraform
ARG TERRAFORM_VERSION
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    mv terraform /usr/local/bin/ \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \


# Clean up
RUN rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /terraform

# Default command
CMD ["/usr/local/bin/terraform"]
