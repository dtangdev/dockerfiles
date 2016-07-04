FROM leadz/symfony-base:latest

MAINTAINER Brice MANCONE <brice.mancone@gmail.com>

RUN apt-get update && apt-get install -y nginx

# Copy the configuration files
COPY ./nginx.conf /etc/nginx/
COPY ./symfony.conf /etc/nginx/sites-available/
COPY ./upstream.conf /etc/nginx/conf.d/

# Setup the configuration files
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony.conf

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx"]

EXPOSE 80