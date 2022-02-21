docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-tracker:latest --push torrust-tracker
docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-frontend:latest --push torrust-frontend
docker buildx build --platform linux/amd64,linux/arm64 -t zorlin/torrust-backend:latest --push torrust-backend
