FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl        \
    unzip  \
    xmlstarlet  \
    openjdk-11-jre-headless \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr

RUN mkdir -p /opt && \
    curl -O https://shibboleth.net/downloads/tools/xmlsectool/3.0.0/xmlsectool-3.0.0-bin.zip && \
    unzip xmlsectool-3.0.0-bin.zip && \
    mv xmlsectool-3.0.0 /opt/xmlsectool && \
    rm xmlsectool-3.0.0-bin.zip

RUN mkdir -p /opt/fetch

COPY fetch-xml.sh renater-metadata-signing-cert-2016.pem /opt/fetch/

ENTRYPOINT /opt/fetch/fetch-xml.sh
