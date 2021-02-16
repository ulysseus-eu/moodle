FROM moodlehq/moodle-php-apache:7.4

RUN a2enmod ssl headers

COPY --chown=root:root learning-ssl.conf /etc/apache2/sites-enabled
COPY --chown=www-data:www-data moodle /var/www/html
COPY --chown=www-data:www-data config.php /var/www/html/

RUN mkdir /data && chmod a+w /data

RUN echo "Servername learning.educalliance.eu" >> /etc/apache2/apache2.conf

USER www-data
