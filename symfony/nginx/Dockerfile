FROM leadz/symfony-base:latest

MAINTAINER Brice MANCONE <brice.mancone@gmail.com>

# nginx sources
RUN sh -c "echo 'deb http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list"
RUN sh -c "echo 'deb-src http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list"
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -

RUN apt-get update && apt-get install -y nginx

# Setup the configuration files
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/
COPY ./symfony.conf /etc/nginx/conf.d/
COPY ./upstream.conf /etc/nginx/conf.d/

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx"]

EXPOSE 80