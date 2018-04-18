ARG SOURCE_REGISTRY=store/softwareag
ARG RELEASE=10.2

FROM $SOURCE_REGISTRY/commandcentral:$RELEASE-server
# customize Command Central settings example
RUN echo com.softwareag.platform.management.client.template.composite.skip.restart.runtimes=true>>$SAG_HOME/profiles/CCE/configuration/config.ini
