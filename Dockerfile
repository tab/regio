FROM ruby:3.1.3-alpine3.17

WORKDIR /package

COPY . .

RUN apk add --update-cache --no-cache --virtual .build-deps g++ make  \
    && apk add --update-cache --no-cache gcompat git openssh-client \
    && bundle install --jobs $(nproc) --retry 3 \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete \
    && apk --purge del .build-deps
