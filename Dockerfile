FROM alpine:3.11.0 as builder

MAINTAINER Frank<franklan118@gmail.com>

RUN apk add --no-cache unzip

ENV DZ_URL https://bitbucket.org/vot/discuz.ml/get/tip.zip

WORKDIR /src/app
ADD ${DZ_URL} /tmp/discuz.zip
RUN unzip /tmp/discuz.zip

FROM php:7.4.1-apache

ENV DZ_WWW_ROOT /var/www/html

RUN docker-php-ext-install mysqli pdo_mysql

COPY --from=builder /src/app/vot-discuz.ml-d0b4974a0a3c/upload/ ${DZ_WWW_ROOT}

WORKDIR ${DZ_WWW_ROOT}
RUN chmod a+w -R config data uc_server/data uc_client/data

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 80

