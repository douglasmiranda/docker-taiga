FROM nginx:1.10.2
MAINTAINER Douglas Miranda <douglasmirandasilva@gmail.com>

RUN mkdir /taiga_frontend
WORKDIR /taiga_frontend

RUN apt-get update && apt-get install -y git \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone -b stable --single-branch https://github.com/taigaio/taiga-front-dist.git ./

RUN mkdir /taiga_frontend/logs
COPY nginx/ /etc/nginx/conf.d/

COPY scripts/ /scripts/
RUN chmod +x /scripts/entrypoint.sh
RUN chown -R nginx /taiga_frontend \
    && chown -R nginx /scripts/
