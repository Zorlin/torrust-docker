#!/bin/bash
# Builds and publishes dual-architecture builds for all 3 containers to Docker Hub.
docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-tracker:latest --push torrust-tracker
docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-frontend:latest --push torrust-frontend
docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-backend:latest --push torrust-backend
# Pushes as the version tag specified
if [ -n "$1" ]; then
	docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-tracker:$1 --push torrust-tracker
	docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-frontend:$1 --push torrust-frontend
	docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-backend:$1 --push torrust-backend
fi
