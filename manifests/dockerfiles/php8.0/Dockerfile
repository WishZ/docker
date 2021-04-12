FROM php:8.0.3-fpm-alpine3.13

RUN echo http://mirrors.ustc.edu.cn/alpine/v3.13/main > /etc/apk/repositories && \
echo http://mirrors.ustc.edu.cn/alpine/v3.13/community >> /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add m4 autoconf make gcc g++ linux-headers wget zlib-dev git libxml2 libxml2-dev oniguruma oniguruma-dev
RUN apk add --update curl curl-dev libzip-dev openssl && \
        wget https://mirrors.aliyun.com/composer/composer.phar && mv composer.phar /usr/local/bin/composer && \
            chmod +x /usr/local/bin/composer && \
            composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
RUN apk add libpng libpng-dev libjpeg-turbo-dev libwebp-dev libxpm-dev gd vim

RUN docker-php-ext-install zip bcmath pdo_mysql mysqli mbstring opcache xml soap curl
RUN docker-php-ext-install gd opcache

RUN pecl channel-update pecl.php.net && pecl install redis && pecl install xlswriter
RUN docker-php-ext-enable redis
RUN docker-php-ext-enable xlswriter

RUN sed -i "s/;clear_env = no/clear_env = no/p" /usr/local/etc/php-fpm.d/www.conf &&\
    sed -i "s/daemonize = yes/daemonize = no/p" /usr/local/etc/php-fpm.conf &&\
	sed -i 's/listen = 127.0.0.1:9000/listen = [::]:9000/p' /usr/local/etc/php-fpm.d/www.conf &&\
	sed -i '/listen.allowed_clients = 127.0.0.1/d' /usr/local/etc/php-fpm.d/www.conf &&\
	sed -i 's/error_log = \/var\/log\/php-fpm\/error.log/error_log = \/www\/docker\/manifests\/runtime\/logs\/php-fpm\/error.log/p' /usr/local/etc/php-fpm.conf

COPY php.ini /usr/local/etc/php/php.ini

COPY docker-entrypoint.sh /usr/local/bin/
EXPOSE 9000
RUN ["chmod", "+x", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["/bin/sh", "/usr/local/bin/docker-entrypoint.sh"]
