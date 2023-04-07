FROM alpine:latest

ENV TF_VERSION=1.3.0

ENV TG_VERSION=v0.45.0

RUN apk update && \
    apk add --no-cache \
        ca-certificates \
        git \
        curl \
        python3 \
        py-pip && \
    pip install awscli && \
    apk add --no-cache \
        unzip && \
    curl -sSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform.zip && \
    curl -o /usr/local/bin/terragrunt -fsSL "https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_amd64" \
    && chmod +x /usr/local/bin/terragrunt

CMD ["/bin/sh"]
