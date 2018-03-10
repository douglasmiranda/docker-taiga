FROM node:8.9-alpine

LABEL maintainer="douglasmirandasilva@gmail.com"
LABEL taiga_version="branch:master"

ENV TAIGA_VERSION master

WORKDIR /taiga_events
COPY scripts/ /scripts/
# Getting from branch master, they don't provide tags, or stable branch
# https://github.com/taigaio/taiga-events/issues/8
ADD https://github.com/taigaio/taiga-events/archive/${TAIGA_VERSION}.tar.gz /taiga_events/
RUN tar -xzf ${TAIGA_VERSION}.tar.gz -C ./ taiga-events-master/ --strip-components=1 \
    && rm ${TAIGA_VERSION}.tar.gz \
    && npm install --production && npm install -g coffee-script \
    && addgroup -S taiga && adduser -S -G taiga taiga \
    && chown -R taiga /taiga_events \
    && chown -R taiga /scripts/ \
    && chmod +x /scripts/entrypoint.sh

USER taiga
ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["coffee", "index.coffee"]
