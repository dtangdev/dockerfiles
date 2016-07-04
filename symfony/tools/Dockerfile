FROM leadz/symfony-base:latest

MAINTAINER Brice MANCONE <brice.mancone@gmail.com>

# Set the workdir
WORKDIR /home/docker

# Make sure that the user has full rights in its home directory
RUN chown -R docker:docker /home/docker

# Add php7 repository
RUN apt-get update && apt-get install -y wget curl apt-utils
RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list
RUN curl https://www.dotdeb.org/dotdeb.gpg 2> /dev/null | apt-key add -

# Add nodejs repository
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

# Install the required packages
RUN apt-get update && apt-get install -y \
    git \
    xmlstarlet \
    sudo \
    php7.0-dev \
    php7.0-common \
    php7.0-cli \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-apcu \
    php7.0-gd \
    php7.0-curl \
    php7.0-intl \
    php7.0-xdebug \
    php7.0-xml \
    php7.0-memcache \
    ant \
    unzip \
    zsh \
    nodejs

# Install npm
RUN npm install npm -g

# Change docker user default shell
RUN chsh -s /usr/bin/zsh docker

# Install ohmyzsh
RUN su docker -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install composer globally
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

ADD zshrc /home/docker/.zshrc

# Entrypoint
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/bin/zsh"]
