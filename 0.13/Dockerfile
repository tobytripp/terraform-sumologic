ARG TERRAFORM_VERSION=0.13.6
FROM hashicorp/terraform:${TERRAFORM_VERSION}

ENV TERRAGRUNT_VERSION=0.28.2
ENV TERRAGRUNT_BINARY=terragrunt_linux_amd64
ENV TERRAGRUNT_URI=https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/${TERRAGRUNT_BINARY}

RUN wget ${TERRAGRUNT_URI} \
        && mv ${TERRAGRUNT_BINARY} /bin/terragrunt \
        && chmod +x /bin/terragrunt
RUN apk add bash

WORKDIR /usr/src/app

COPY bin bin
COPY iac iac

VOLUME /usr/src/app/iac
VOLUME /usr/src/app/bin
VOLUME /root/.ssh

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/bin/sh"]
