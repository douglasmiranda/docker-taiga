FROM python:3.6-alpine3.6 as BUILDER

ENV TAIGA_VERSION 3.3.7

RUN apk update \
    && apk add --virtual build-dependencies \
    # Essentials
    gcc musl-dev libressl-dev \
    # Postgres python client (psycopg2) build dependency
    postgresql-dev \
    # Pillow / PIL build dependencies
    freetype-dev jpeg-dev libwebp-dev tiff-dev libpng-dev lcms2-dev \
    openjpeg-dev zlib-dev libxslt-dev libxml2-dev libffi-dev \
    # Other tools
    git

WORKDIR /taiga_backend

ADD https://github.com/taigaio/taiga-back/archive/${TAIGA_VERSION}.tar.gz ./
    RUN tar -xzf ${TAIGA_VERSION}.tar.gz -C ./ taiga-back-${TAIGA_VERSION} --strip-components=1
RUN rm ${TAIGA_VERSION}.tar.gz

# Don't want pip to use git, so I'm replacing with pypi.  
RUN sed -i 's,git+https://github.com/Xof/django-pglocks.git,django-pglocks==1.0.2,g' requirements.txt

# local.py and checkdb.py and celery
# using gevent to run taiga gunicorn (workers)
# using gevent on celery (workers)
RUN echo "django-environ==0.4.0" >> requirements.txt
RUN echo "gevent==1.1.2" >> requirements.txt
RUN echo "django-anymail==0.5" >> requirements.txt

RUN pip wheel --wheel-dir=./taiga_python_dependencies -r requirements.txt


# FINAL IMAGE
FROM python:3.6-alpine3.6

LABEL maintainer="douglasmirandasilva@gmail.com"
LABEL taiga_version="tag:3.3.7"

WORKDIR /taiga_backend

COPY --from=BUILDER /taiga_backend ./

RUN apk add --no-cache \
    # Pillow / PIL
    freetype jpeg libwebp tiff libpng lcms2 openjpeg zlib libxslt libxml2 libffi \
    # Postgres python client
    libpq \
    # Needed for localization stuff: python manage.py compilemessages
    gettext \
    # Other tools
    git

RUN pip install --no-cache-dir --no-index --find-links=taiga_python_dependencies -r requirements.txt \
    && rm -R ./taiga_python_dependencies \
    && python manage.py compilemessages

COPY local.py settings/local.py
COPY celery_local.py settings/celery_local.py
COPY scripts/ /scripts/

RUN mkdir /taiga_backend/media && mkdir /taiga_backend/static-root \
    && addgroup -S taiga && adduser -S -G taiga taiga \
    && chown -R taiga ./ \
    && chown -R taiga /scripts/ \
    && chmod +x /scripts/entrypoint.sh

USER taiga
