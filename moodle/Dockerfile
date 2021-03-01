FROM moodlehq/moodle-php-apache:7.4

RUN apt-get update && apt-get install -y \
    libapache2-mod-shib \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod ssl headers shib

RUN sed -i -e 's/Listen 80/# Listen 80/' /etc/apache2/ports.conf
RUN sed -i -e 's/SSLProtocol all -SSLv3/SSLProtocol TLSv1.3/' /etc/apache2/mods-available/ssl.conf

COPY --chown=root:root learning-ssl.conf /etc/apache2/sites-enabled
COPY --chown=www-data:www-data config.php /var/www/html/

RUN mkdir /data && chmod a+w /data

RUN echo "Servername learning.educalliance.eu" >> /etc/apache2/apache2.conf

USER www-data
