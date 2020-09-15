FROM daocloud.io/library/ubuntu:20.04

RUN apt-get update \
 && apt-get install -y php php-dev php-redis php-bcmath php-xml php-gd php-mysql zlib1g-dev re2c gcc g++ make curl

RUN \
    curl                      \
        -sfL                  \
        --connect-timeout 5   \
        --max-time         15 \
        --retry            5  \
        --retry-delay      2  \
        --retry-max-time   60 \
        http://getcomposer.org/installer | php -- --install-dir="/usr/bin" --filename=composer && \
    chmod +x "/usr/bin/composer"                                                               && \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ && \
    composer self-update

RUN pecl install swoole  \
 && pecl install xlswriter

 COPY . /www
 WORKDIR /www
 CMD ["php","bin/hyperf.php start"]

