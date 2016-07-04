# Symfony dockerfiles

- `base` : the base image
- `nginx` : the nginx container
- `php-fpm` : the php-fpm container
- `tools` : a set of tools to use symfony in the cli

## Versions

**Nginx** : 

- nginx 1.6.2 (from debian:jessie)

**Php-fpm** : 

- php/php-fpm 7.0 (with extensions: mcrypt, mysql, apcu, gd, curl, intl, xdebug, memcache, apcu, xml)
- blackfire

**Tools** : 

- node (4.x) & npm
- composer
- ant
- zsh & oh-my-zsh
- curl
- git
- wget

## How to use it

Use the `tools` to use composer or symfony cli tools : `docker-compose run --rm tools`

Sample docker-compose.yml file : 

```yml

version: '2'

services:

  # Data container
  data:
      image: leadz/symfony-base
      volumes:
          - ".:/home/docker/public_html"
      user: docker
      working_dir: "/home/docker/public_html"
      tty: true

  # Nginx container
  nginx:
      image: leadz/symfony-nginx
      volumes_from:
          - data
      ports:
          - "80:80"
      links:
          - php

  # Php container
  php:
      image: leadz/symfony-php-fpm
      volumes_from:
          - data
      expose:
          - "9000"
      links:
          - db
          - blackfire

  # Blackfire container
  blackfire:
      image: blackfire/blackfire
      expose:
          - "8707"
      environment:
          - "BLACKFIRE_SERVER_ID=XXXXXXXXXXXXXXXXXXXXXXXXXX"
          - "BLACKFIRE_SERVER_TOKEN=XXXXXXXXXXXXXXXXXXXXXXXX"

  # Mysql container
  db:
      image: mysql
      expose:
          - "3306"
      environment:
          - "MYSQL_ROOT_PASSWORD=root"
          - "MYSQL_DATABASE=docker"
          - "MYSQL_USER=docker"
          - "MYSQL_PASSWORD=docker"

  # PMA container
  pma:
      image: nazarpc/phpmyadmin
      links:
          - db:mysql
      ports:
          - "81:80"

  # Tools container
  tools:
     image: leadz/symfony-tools
     volumes:
         - $SSH_AUTH_SOCK:$SSH_AUTH_SOCK
     volumes_from:
         - data
     working_dir: "/home/docker/public_html"
     user: docker
     expose:
         - "9000"
     links:
         - db
     environment:
         - SSH_AUTH_SOCK
         - OH_MY_ZSH_THEME=bureau

```