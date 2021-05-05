FROM moodlehq/moodle-php-apache:7.4

RUN apt-get update && apt-get install -y \
    libapache2-mod-shib \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod ssl headers shib

COPY --chown=root:root learning-ssl.conf /etc/apache2/sites-enabled

RUN mkdir /data && chmod a+w /data

RUN echo "Servername ulysseus.eu" >> /etc/apache2/apache2.conf

USER www-data
