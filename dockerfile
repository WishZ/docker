
FROM daocloud.io/library/php:7.4-cli-alpine3.12

RUN echo http://mirrors.ustc.edu.cn/alpine/v3.12/main > /etc/apk/repositories && \
echo http://mirrors.ustc.edu.cn/alpine/v3.12/community >> /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add m4 autoconf make gcc g++ linux-headers wget zlib-dev git libxml2 libxml2-dev oniguruma oniguruma-dev
RUN apk add --update curl curl-dev libzip-dev openssl && \
        wget https://mirrors.aliyun.com/composer/composer.phar && mv composer.phar /usr/local/bin/composer && \
            chmod +x /usr/local/bin/composer && \
            composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

RUN apk add libpng libpng-dev libjpeg-turbo-dev libwebp-dev libxpm-dev gd

RUN docker-php-ext-install zip bcmath pdo_mysql mysqli mbstring opcache xml soap curl \
            && docker-php-ext-install gd

RUN pecl channel-update pecl.php.net && pecl install swoole && pecl install redis && pecl install xlswriter

RUN docker-php-ext-enable swoole
RUN docker-php-ext-enable redis
RUN docker-php-ext-enable xlswriter
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
COPY . /www
WORKDIR /www

#RUN composer update -vvv

EXPOSE 9501

#ENTRYPOINT ["php", "/www/bin/hyperf.php", "start"]
