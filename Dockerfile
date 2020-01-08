ARG TERRAFORM_VERSION=0.12.18
FROM hashicorp/terraform:${TERRAFORM_VERSION}

ENV SUMOLOGIC_VERSION=1.1.0
ENV SUMOLOGIC_ARCHIVE=sumologic-terraform-provider_${SUMOLOGIC_VERSION}_Linux_64-bit.zip
ENV SUMOLOGIC_URI=https://github.com/SumoLogic/sumologic-terraform-provider/releases/download/v${SUMOLOGIC_VERSION}/${SUMOLOGIC_ARCHIVE}
# ENV PLUGIN_PATH=~/.terraform.d/plugins
ENV PLUGIN_PATH=/bin

RUN wget ${SUMOLOGIC_URI} \
        && mkdir -p sumologic-terraform-provider \
        && mkdir -p ${PLUGIN_PATH} \
        && unzip ${SUMOLOGIC_ARCHIVE} -d sumologic-terraform-provider \
        && mv sumologic-terraform-provider/terraform-provider-sumologic \
              ${PLUGIN_PATH}/ \
        && rm -r ${SUMOLOGIC_ARCHIVE} sumologic-terraform-provider

ENV TERRAGRUNT_VERSION=0.21.10
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
