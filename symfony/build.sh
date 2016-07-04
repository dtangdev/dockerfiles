#!/usr/bin/env bash

# Builds the container
docker build -t leadz/symfony-base base
docker build -t leadz/symfony-nginx nginx
docker build -t leadz/symfony-php-fpm php-fpm
docker build -t leadz/symfony-tools tools