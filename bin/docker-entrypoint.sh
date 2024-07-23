#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Wait for the database to be ready.
until pg_isready -h database -p 5432 -U blogpg; do
  echo >&2 "Postgres is unavailable - sleeping"
  sleep 1
done

# Create and migrate the database if needed.
if [[ -z `psql -Atqc "\\list blogpg_development"` ]]; then
  echo "Database does not exist. Creating..."
  bundle exec rails db:create db:migrate db:seed
  echo "Database created and seeded."
else
  echo "Database exists. Running migrations..."
  bundle exec rails db:migrate db:seed
fi

exec "$@"
