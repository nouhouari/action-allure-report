FROM openjdk:8-jre-alpine
LABEL maintainer="andrea.fiore@lenses.io"
LABEL maintainer="houarinourredine@gmail.com"

ARG RELEASE=2.17.2
ARG ALLURE_REPO=https://github.com/allure-framework/allure2/releases/download/${RELEASE}/allure-${RELEASE}

RUN apk update
RUN apk add bash 
RUN apk add wget 
RUN apk add unzip 

RUN wget --no-verbose -O /tmp/allure-$RELEASE.zip $ALLURE_REPO.zip \
  && unzip /tmp/allure-$RELEASE.zip -d / \
  && rm -rf /tmp/*

RUN rm -rf /var/cache/apk/*

RUN chmod -R +x /allure-$RELEASE/bin

ENV ROOT=/app
ENV PATH=$PATH:/allure-$RELEASE/bin

RUN mkdir -p $ROOT

WORKDIR $ROOT
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
