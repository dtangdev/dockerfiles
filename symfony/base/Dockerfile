FROM debian:jessie

MAINTAINER Brice MANCONE <brice.mancone@gmail.com>

# Install some packages and setup the locales
RUN apt-get update && apt-get -y --no-install-recommends install locales curl wget ca-certificates vim sudo
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && locale-gen

# Create the user and the group
RUN groupadd -g 1000 docker && useradd -u 1000 -g docker docker && echo "docker:docker" | chpasswd && adduser docker sudo