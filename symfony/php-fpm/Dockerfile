FROM leadz/symfony-base:latest

MAINTAINER Brice MANCONE <brice.mancone@gmail.com>

# Add the php7 repository
RUN mkdir -p /run/php
RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list
RUN wget -O - https://www.dotdeb.org/dotdeb.gpg | apt-key add -

# Install the packages
RUN apt-get update && apt-get install -y \
    php7.0-dev \
    php7.0-common \
    php7.0-cli \
    php7.0-fpm \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-apcu \
    php7.0-gd \
    php7.0-curl \
    php7.0-intl \
    php7.0-xdebug \
    php7.0-memcache \
    php7.0-apcu \
    php7.0-xml

# Install blackfire
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > /etc/php/7.0/fpm/conf.d/blackfire.ini


# Add the app configuration
ADD symfony.ini /etc/php/7.0/fpm/conf.d/
ADD symfony.ini /etc/php/7.0/cli/conf.d/
ADD symfony.pool.conf /etc/php/7.0/fpm/pool.d/
RUN rm -f /etc/php/7.0/fpm/pool.d/www.conf

CMD ["php-fpm7.0", "-F"]

EXPOSE 9000
