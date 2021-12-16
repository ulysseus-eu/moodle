FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    shibboleth-sp-common \
    shibboleth-sp-utils \
    && rm -rf /var/lib/apt/lists/*

# RUN sed -E -i -e 's|/learn/|/'"${URL_DIRECTORY_ON_WEB_SERVER:-learn}"'/|g' /etc/shibboleth/shibboleth2.xml

CMD ["/usr/sbin/shibd", "-f", "-F"]
