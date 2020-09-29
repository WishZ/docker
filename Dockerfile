
FROM daocloud.io/ubuntu:20.04
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && apt-get clean && apt-get update && apt-get -y upgrade
RUN apt-get install -y curl wget m4 autoconf make gcc g++ wget git libxml2 libxml2-dev zlib1g-dev
RUN apt-get install -y php php-dev php-gd php-redis php-mysql php-zip php-curl php-mbstring php-bcmath
RUN wget https://mirrors.aliyun.com/composer/composer.phar && mv composer.phar /usr/local/bin/composer && \
            chmod +x /usr/local/bin/composer && \
            composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
RUN pecl channel-update pecl.php.net
RUN pecl install swoole
RUN pecl install redis && pecl install xlswriter

RUN echo extension=swoole.so > /etc/php/7.4/cli/conf.d/20-swoole.ini
RUN echo swoole.use_shortname=Off >> /etc/php/7.4/cli/conf.d/20-swoole.ini
RUN echo extension=redis.so > /etc/php/7.4/cli/conf.d/20-redis.ini
RUN echo extension=xlswriter.so > /etc/php/7.4/cli/conf.d/20-xlswriter.ini

# RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
# COPY . /www
# WORKDIR /www

#RUN composer update -vvv

EXPOSE 9501

#ENTRYPOINT ["php", "/www/bin/hyperf.php", "start"]
