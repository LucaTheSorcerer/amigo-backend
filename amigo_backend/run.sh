#!/bin/bash
## Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
## https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf
#
#set -e
## shellcheck disable=SC2039
#source /opt/asdf/asdf.sh
#
## Ensure the app's dependencies are installed
#mix deps.get
#
## Prepare Dialyzer if the project has Dialyxer set up
#if mix help dialyzer >/dev/null 2>&1
#then
#  echo "\nFound Dialyxer: Setting up PLT..."
#  mix do deps.compile, dialyzer --plt
#else
#  echo "\nNo Dialyxer config: Skipping setup..."
#fi
#echo "\nListing the /app directory contents..."
#ls -la /app
#
#
## Install JS libraries
#echo "\nInstalling JS..."
#cd assets
#echo "Current directory: $(pwd)"
#echo "Listing the contents of the current directory:"
#ls -la
#npm install
#cd ..
#
#
#while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
#do
#  echo "$(date) - waiting for database to start"
#  sleep 2
#done
#
## Create, migrate, and seed database if it doesn't exist.
#if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
#  echo "Database $PGDATABASE does not exist. Creating..."
#  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
#  mix ecto.create
#  mix ecto.migrate
#  mix run priv/repo/seeds.exs
#  echo "Database $PGDATABASE created."
#fi
#
##echo "\nPostgres is available: continuing with database setup..."
##
###Analysis style code
### Prepare Credo if the project has Credo start code analyze
##if mix help credo >/dev/null 2>&1
##then
##  echo "\nFound Credo: analyzing..."
##  mix credo || true
##else
##  echo "\nNo Credo config: Skipping code analyze..."
##fi
##
### Potentially Set up the database
##mix ecto.create
##mix ecto.migrate
#
#echo "\nTesting the installation..."
## "Prove" that install was successful by running the tests
#mix test
#
#echo "\n Launching Phoenix web server..."
## Start the phoenix web server
#mix phx.server




set -e

source /opt/asdf/asdf.sh

# Ensure the app's dependencies are installed
mix deps.get

if [[ -f assets/package.json ]]; then
  # Install the app's dependencies with npm
  cd assets
  npm install
  cd ..
fi

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  createdb -E UTF8 $PGDATABASE -l en_US.UTF-8 -T template0
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo "Database $PGDATABASE created."
fi

mix phx.server