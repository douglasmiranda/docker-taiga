FROM node:6.5.0-slim
MAINTAINER Douglas Miranda <douglasmirandasilva@gmail.com>

RUN mkdir /taiga_events
WORKDIR /taiga_events

RUN groupadd -r taiga && useradd -r -g taiga taiga

RUN apt-get update && apt-get install -y git \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone -b master --single-branch https://github.com/taigaio/taiga-events.git ./

RUN npm install --production && npm install -g coffee-script
# RUN mkdir /taiga_events/logs

COPY scripts/ /scripts/
RUN chmod +x /scripts/entrypoint.sh
RUN chown -R taiga /taiga_events \
    && chown -R taiga /scripts/
