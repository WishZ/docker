#!/bin/bash
# auther: ge2x3k2@gmail.com

echo "info: starting php-fpm.."
php-fpm -c /usr/local/etc/php/php.ini -y /usr/local/etc/php-fpm.conf
