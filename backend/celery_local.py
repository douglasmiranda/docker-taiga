from .celery import *

broker_url = 'amqp://taiga:taiga@rabbitmq:5672/taiga'
result_backend = 'redis://redis:6379/0'
