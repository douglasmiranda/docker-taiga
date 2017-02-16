=============================================
Deploy your Taiga services with Docker
=============================================

    *Taiga is a project management platform for agile developers & designers and project managers who want a beautiful tool that makes work truly enjoyable. http://taiga.io*

.. image:: https://raw.githubusercontent.com/douglasmiranda/docker-taiga/master/docker-taiga.jpg
    :alt: Docker Taiga

I've tried to containerize every module, so we have:

* frontend_
* backend_ 
 * postgres_
 * celery worker
  * redis
 * rabbitmq 
* events_
 * rabbitmq

Bonus: I've added a config if you want to use mailgun.

.. _frontend: frontend/
.. _backend: https://github.com/taigaio/taiga-back
.. _postgres: postgres/
.. _events: events/

Quickstart
----------

I'm going to write some better instructions soon, but for now, if you want to
try it, just type:

::

    docker-compose up

PS: This will load the *docker-compose.override.yml* too (useful for local / dev envs)

On production, just rename the file **productionenv-template--rename-this-file.env** to **production.env**

::

    docker-compose -f docker-compose.yml -f docker-compose.production.yml up

Lear more about `docker compose override and extends`_

.. _`docker compose override / extends`: https://docs.docker.com/compose/extends/

Credits
-------

https://taigaio.github.io/taiga-doc/dist/setup-production.html

Inspired by:
https://github.com/benhutchins/docker-taiga
https://github.com/ipedrazas/taiga-docker