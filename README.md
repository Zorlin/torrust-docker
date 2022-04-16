# torrust-docker
![GitHub CI](https://github.com/zorlin/torrust-docker/actions/workflows/image.yml/badge.svg)

It's [Torrust](https://torrust.com), in Docker. Cool!

## Requirements

* Docker installed and working
* docker-compose

## Getting started

Check out a copy of this repository.

```
git clone https://github.com/zorlin/torrust-docker
cd torrust-docker
```

You'll need to generate some configuration files with which to run Torrust.

```
# Replace your.domain with your domain name in the Caddyfile
# Eg: 's/example.com/torrust.com/g'
sed -i 's/example.com/your.domain/g' Caddyfile

# Create a named Docker volume for Caddy
docker volume create --name=caddy_data

# Generate tracker and backend configuration
docker run --rm zorlin/torrust-tracker:latest > tracker-config.toml
docker run --rm zorlin/torrust-backend:latest > backend-config.toml

# Adjust the configuration to reflect our Docker environment
sed -i 's/"127.0.0.1:1212"/"0.0.0.0:1212"/g' tracker-config.toml
sed -i 's/admin = "MyAccessToken"/token = "MyAccessToken"/g' tracker-config.toml
# Replace your.domain with your domian name
sed -i 's/localhost:6969/your.domain:6969/g' backend-config.toml
sed -i 's/localhost:1212/tracker:1212/g' backend-config.toml

# Create configuration for the frontend - replace "your.domain" with your domain name
echo "VITE_API_BASE_URL=https://your.domain/api" > frontend.env

# Build the frontend files
docker run --rm \
  -v "$(pwd)"/frontend.env:/opt/torrust/torrust/frontend/.env \
  -v "$(pwd)"/data/frontend/dist:/opt/torrust/torrust/frontend/dist \
  zorlin/torrust-frontend:latest
  
# Create a place for backend data to be stored
mkdir -p data/backend/
```

Once you've created the configuration files and frontend build, and created a place for backend data, simply bring up the service with Docker Compose;

`docker-compose up -d`

## What just happened?

We set up a basic Torrust instance which runs entirely in Docker and published it to the web. This is a very early version of the Docker tooling for Torrust but should soon support (almost) everything you'd want to do with Torrust. More documentation coming soon!

## Credits

torrust-docker was created by [Zorlin](https://github.com/zorlin/) and donated to the Torrust project in February 2022.
