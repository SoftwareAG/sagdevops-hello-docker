ARG SOURCE_REGISTRY=store/softwareag
FROM $SOURCE_REGISTRY/commandcentral:10.2-server

# customize Command Central settings example
RUN echo com.softwareag.platform.management.client.template.composite.skip.restart.runtimes=true>>$SAG_HOME/profiles/CCE/configuration/config.ini
