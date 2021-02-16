FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    shibboleth-sp-common \
    shibboleth-sp-utils \
    && rm -rf /var/lib/apt/lists/*

CMD ["/usr/sbin/shibd", "-f", "-F"]
