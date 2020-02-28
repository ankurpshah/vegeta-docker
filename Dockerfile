FROM alpine:3.10

LABEL \
  maintainer="Ankur Shah <ankurpshah@gmail.com>" \
  org.opencontainers.image.title="ankurpshah" \
  org.opencontainers.image.description="Docker image for the Vegeta HTTP load testing tool." \
  org.opencontainers.image.authors="Ankur Shah <ankurpshah@gmail.com>" \
  org.opencontainers.image.url="https://github.com/ankurpshah/vegeta-docker" \
  org.opencontainers.image.vendor="https://ankurpshah.com" \
  org.opencontainers.image.licenses="MIT"

ENV VEGETA_VERSION 12.8.0

RUN set -ex \
 && apk add --no-cache ca-certificates \
 && apk add --no-cache --virtual .build-deps \
    openssl \
 && wget -q "https://github.com/tsenart/vegeta/releases/download/v$VEGETA_VERSION/vegeta-$VEGETA_VERSION-linux-amd64.tar.gz" -O /tmp/vegeta.tar.gz \
 && cd bin \
 && tar xzf /tmp/vegeta.tar.gz \
 && rm /tmp/vegeta.tar.gz \
 && apk del .build-deps 

RUN apk -v --update add \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

CMD [ "/bin/vegeta", "-help" ]