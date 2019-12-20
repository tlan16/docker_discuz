FROM alpine:3.11.0 as builder

MAINTAINER Frank<franklan118@gmail.com>

ENV DZ_URL https://gitee.com/ComsenzDiscuz/DiscuzX.git

RUN apk add --no-cache unzip git

RUN git clone --depth 1 ${DZ_URL} /src/app

FROM php:7.4.1-apache

ENV DZ_WWW_ROOT /var/www/html

RUN docker-php-ext-install mysqli pdo_mysql

COPY --from=builder /src/app/upload/ ${DZ_WWW_ROOT}

WORKDIR ${DZ_WWW_ROOT}
RUN chmod a+w -R config data uc_server/data uc_client/data

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 80

