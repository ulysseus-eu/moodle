FROM moodlehq/moodle-php-apache:7.4

RUN apt-get update && apt-get install -y \
    libapache2-mod-shib \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod ssl headers shib

RUN sed -i -e 's/Listen 80/# Listen 80/' /etc/apache2/ports.conf
RUN sed -i -e 's/SSLProtocol all -SSLv3/SSLProtocol TLSv1.3/' /etc/apache2/mods-available/ssl.conf

COPY --chown=root:root learning-ssl.conf /etc/apache2/sites-enabled
# RUN sed -E -i -e 's|<Location /learn|<Location /'"${URL_DIRECTORY_ON_WEB_SERVER:-learn}"'|g' /etc/apache2/sites-enabled/learning-ssl.conf

RUN mkdir /data && chmod a+w /data

RUN echo "Servername ulysseus.eu" >> /etc/apache2/apache2.conf

RUN /bin/bash -c 'cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini'

# Update Php Settings
RUN sed -E -i -e 's/max_execution_time = 30/max_execution_time = 120/' /usr/local/etc/php/php.ini \
 && sed -E -i -e 's/memory_limit = 128M/memory_limit = 512M/' /usr/local/etc/php/php.ini \
 && sed -E -i -e 's/post_max_size = 8M/post_max_size = 200M/' /usr/local/etc/php/php.ini \
 && sed -E -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /usr/local/etc/php/php.ini

# RUN sed -E -i -e 's|https://ulysseus.eu/learn|https://ulysseus.eu/'"${URL_DIRECTORY_ON_WEB_SERVER:-learn}"'|' /var/www/html/${URL_DIRECTORY_ON_WEB_SERVER:-learn}/config.php

USER www-data
