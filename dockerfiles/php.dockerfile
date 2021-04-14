FROM php:7.4-fpm-alpine

WORKDIR /var/www/html

COPY src .

RUN docker-php-ext-install pdo pdo_mysql

# creates a user called laravel and gives permissions to the user
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN chown -R laravel:www-data /var/www/html

RUN chmod -R 755 /var/www/html

RUN chmod -R 775 /var/www/html/storage
 
USER laravel