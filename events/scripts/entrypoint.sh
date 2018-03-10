#!/bin/sh
set -e

if [ ! -f /taiga_events/config.json ]; then
    echo "Generating /taiga_events/config.json file..."
    cat > /taiga_events/config.json <<EOF
{
    "url": "amqp://taiga:taiga@rabbitmq:5672/taiga",
    "secret": "$TAIGA_SECRET",
    "webSocketServer": {
        "port": 8888
    }
}

EOF
fi

exec "$@"
