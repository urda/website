FROM alpine:3

ENV APP_ROOT /app
ENV TMP_ROOT /app/tmp
ENV WEB_ROOT /app/web

ENV DOCKER_CONTAINER true

WORKDIR ${APP_ROOT}

RUN apk add --no-cache \
    ack \
    bash \
    build-base \
    cmake \
    icu-dev \
    nodejs \
    openssl-dev \
    ruby \
    ruby-dev \
    ruby-json \
    ruby-nokogiri \
    zlib-dev \
    && :
RUN gem install bundler --no-document && bundle config --global silence_root_warning 1

WORKDIR ${TMP_ROOT}
ADD Gemfile ${TMP_ROOT}
ADD Gemfile.lock ${TMP_ROOT}
RUN bundle install

WORKDIR ${WEB_ROOT}

CMD make jekyll-serve
