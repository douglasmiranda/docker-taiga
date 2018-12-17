FROM nginx:1.13-alpine

LABEL maintainer="douglasmirandasilva@gmail.com"
LABEL taiga_version="tag:3.3.7-stable"

ENV TAIGA_VERSION 3.3.7-stable

COPY nginx/ /etc/nginx/conf.d/
# Entrypoint
COPY scripts/ /scripts/
# Frontend compiled code
ADD https://github.com/taigaio/taiga-front-dist/archive/${TAIGA_VERSION}.tar.gz /taiga_frontend/
WORKDIR /taiga_frontend
RUN tar -xzf ${TAIGA_VERSION}.tar.gz -C ./ taiga-front-dist-${TAIGA_VERSION}/dist --strip-components=2 \
    && rm ${TAIGA_VERSION}.tar.gz \
    && chown -R nginx /taiga_frontend \
    && chown -R nginx /scripts/ \
    && chmod +x /scripts/entrypoint.sh

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
