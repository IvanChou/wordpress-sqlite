#FROM wordpress:fpm
FROM wordpress:fpm-alpine

COPY config/wp-config.php /var/www/wp-config.php

RUN sed -i 's/pm = dynamic/pm = ondemand/g' /usr/local/etc/php-fpm.d/www.conf && \
    apk add --update curl unzip && rm -Rf /var/cache/apk/* && \
    curl -o /tmp/wpplugin.zip https://downloads.wordpress.org/plugin/sqlite-integration.1.8.1.zip && \
    unzip /tmp/wpplugin.zip -d /usr/src/wordpress/wp-content/plugins/ && \
    rm /tmp/wpplugin.zip && \
    cp /usr/src/wordpress/wp-content/plugins/sqlite-integration/db.php /usr/src/wordpress/wp-content && \
    chown www-data:www-data /var/www/wp-config.php

VOLUME ["/var/www/db"]
