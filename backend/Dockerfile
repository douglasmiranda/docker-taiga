FROM python:3.5.2
MAINTAINER Douglas Miranda <douglasmirandasilva@gmail.com>

RUN mkdir /taiga_backend
WORKDIR /taiga_backend

RUN apt-get update

RUN groupadd -r taiga && useradd -r -g taiga taiga

RUN apt-get install -y build-essential binutils-doc autoconf flex bison \
    libjpeg-dev libfreetype6-dev zlib1g-dev libzmq3-dev libgdbm-dev \
    libncurses5-dev automake libtool libffi-dev curl git tmux gettext \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b stable --single-branch https://github.com/taigaio/taiga-back.git ./
RUN pip install -r requirements.txt
# local.py and checkdb.py and celery
# using gevent to run taiga gunicorn (workers)
# using gevent on celery (workers)
RUN pip install django-environ==0.4.0 gevent==1.1.2 django-anymail==0.5

RUN python manage.py compilemessages

COPY local.py settings/local.py
COPY celery_local.py settings/celery_local.py
COPY scripts/ /scripts/
RUN chmod +x /scripts/entrypoint.sh

RUN mkdir /taiga_backend/media && mkdir /taiga_backend/static-root
RUN chown -R taiga /taiga_backend \
    && chown -R taiga /scripts/ \
    && chown -R taiga /taiga_backend/static-root
