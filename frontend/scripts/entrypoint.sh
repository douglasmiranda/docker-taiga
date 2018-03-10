#!/bin/sh

set -o errexit
set -o pipefail

if [ ! -f /taiga_frontend/conf.json ]; then
    echo "Generating /taiga_frontend/conf.json file..."
    TAIGA_API_URL=${TAIGA_API_URL:-\"/api/v1/\"}
    DEFAULT_LANGUAGE=${DEFAULT_LANGUAGE:-\"en\"}
    TAIGA_EVENTS_URL=${TAIGA_EVENTS_URL:-null}
    cat > /taiga_frontend/conf.json <<EOF
{
    "api": $TAIGA_API_URL,
    "eventsUrl": $TAIGA_EVENTS_URL,
    "eventsMaxMissedHeartbeats": 5,
    "eventsHeartbeatIntervalTime": 60000,
    "debug": ${TAIGA_DEBUG:-false},
    "debugInfo": ${TAIGA_DEBUG:-false},
    "defaultLanguage": $DEFAULT_LANGUAGE,
    "themes": ["taiga"],
    "defaultTheme": "taiga",
    "publicRegisterEnabled": ${TAIGA_PUBLIC_REGISTER_ENABLED:-true},
    "feedbackEnabled": true,
    "privacyPolicyUrl": null,
    "termsOfServiceUrl": null,
    "maxUploadFileSize": null,
    "contribPlugins": []
}
EOF
fi

exec "$@"
