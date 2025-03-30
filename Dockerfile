FROM amazonlinux:latest

# Install dependencies (logs redirected to /dev/null for background logging)
RUN yum install -y unzip git > /dev/null 2>&1

# Install Terraform (logs redirected to /dev/null for background logging)
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip -d /usr/local/bin/ > /dev/null 2>&1 \
    && rm terraform.zip

# Install AWS CLI (logs redirected to /dev/null for background logging)
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip > /dev/null 2>&1 \
    && ./aws/install > /dev/null 2>&1 \
    && rm -rf awscliv2.zip aws/

# Set working directory
WORKDIR /app

# Copy files into the image
COPY . /app

# Use bash shell for entry point
ENTRYPOINT ["/bin/bash"]
