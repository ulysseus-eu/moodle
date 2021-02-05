FROM moodlehq/moodle-php-apache:7.4

COPY --chown=www-data:www-data moodle /var/www/html
COPY --chown=www-data:www-data config.php /var/www/html/

RUN mkdir /data && chmod a+w /data

USER www-data
