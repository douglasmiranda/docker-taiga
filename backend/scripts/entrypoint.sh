#!/bin/sh
set -e

# Setup database automatically if needed
if [ -z "$TAIGA_SKIP_DB_CHECK" ]; then
  DB_CHECK_STATUS=$(python /scripts/checkdb.py)
  if [[ "$DB_CHECK_STATUS" == "missing_django_migrations" ]]; then
    echo "Configuring initial database"
    python /taiga_backend/manage.py migrate --noinput
    python /taiga_backend/manage.py loaddata initial_user
    python /taiga_backend/manage.py loaddata initial_project_templates
    python /taiga_backend/manage.py compilemessages
    python /taiga_backend/manage.py collectstatic --noinput
  fi
fi

# Look for static folder, if it does not exist, then generate it
if [ "$(ls -A /taiga_backend/static-root/ 2> /dev/null)" == "" ]; then
  python /taiga_backend/manage.py collectstatic --noinput
fi

exec "$@"
