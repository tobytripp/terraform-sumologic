ARG TERRAFORM_VERSION=0.11.11
FROM hashicorp/terraform:${TERRAFORM_VERSION}

ENV SUMOLOGIC_VERSION=1.1.0
ENV SUMOLOGIC_ARCHIVE=sumologic-terraform-provider_${SUMOLOGIC_VERSION}_Linux_64-bit.zip
ENV SUMOLOGIC_URI=https://github.com/SumoLogic/sumologic-terraform-provider/releases/download/v${SUMOLOGIC_VERSION}/${SUMOLOGIC_ARCHIVE}

RUN wget ${SUMOLOGIC_URI} \
        && mkdir -p sumologic-terraform-provider \
        && mkdir -p ~/.terraform.d/plugins \
        && unzip ${SUMOLOGIC_ARCHIVE} -d sumologic-terraform-provider \
        && mv sumologic-terraform-provider/terraform-provider-sumologic \
              ~/.terraform.d/plugins/ \
        && rm -r ${SUMOLOGIC_ARCHIVE} sumologic-terraform-provider

WORKDIR /usr/src/app

COPY bin bin
COPY iac iac

VOLUME /usr/src/app/iac
VOLUME /usr/src/app/bin
VOLUME /root/.ssh

# ENTRYPOINT ["terraform"]
CMD ["/bin/sh"]
