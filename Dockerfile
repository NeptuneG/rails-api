FROM ruby:3.0.0-alpine3.13

ENV APP_HOME=/app \
    BUNDLE_PATH=/bundle \
    GEM_PATH=/bundle \
    PACKAGES='build-base git ruby-dev postgresql-dev make g++ musl-dev libffi-dev linux-headers tzdata wget less'

RUN set -x &&\
    echo 'http://dl-cdn.alpinelinux.org/alpine/v3.12/main' >> /etc/apk/repositories &&\
    apk add --update --no-cache &&\
    apk add --update --virtual build-dependencies --no-cache $PACKAGES &&\
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime &&\
    gem install bundler --no-document &&\
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . ./

EXPOSE 3377
