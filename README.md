# torrust-docker

It's [Torrust](https://torrust.com), in Docker. Cool!

## Requirements

* Docker installed and working
* docker-compose

## Getting started

You'll first need to generate some configuration files with which to run Torrust.

```
# Generate tracker and backend configuration
docker run --rm zorlin/torrust-tracker:latest > tracker-config.toml
docker run --rm zorlin/torrust-backend:latest > backend-config.toml
# Create configuration for the frontend - replace "localhost" if needed
echo "VITE_API_BASE_URL=http://localhost/api" > frontend.env
# Build the frontend files
docker run --rm \
  -v "$(pwd)"/frontend.env:/opt/torrust/torrust/frontend/.env \
  -v "$(pwd)"/data/frontend/dist:/opt/torrust/torrust/frontend/dist \
  zorlin/torrust-frontend:latest
```

Once you've created the configuration files and frontend build, simply bring up the service with Docker Compose;

`docker-compose up -d`

You may need to run it a few times ;)

## What just happened?

We set up a basic Torrust instance which runs entirely in Docker and published it to the web. This is a very early version of the Docker tooling for Torrust but should soon support (almost) everything you'd want to do with Torrust. More documentation coming soon!
