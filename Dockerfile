FROM moodlehq/moodle-php-apache:7.4

COPY moodle /var/www/html
COPY config.php /var/www/html/

RUN chown --recursive www-data.www-data /var/www/html

USER www-data
