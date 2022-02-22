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

## Adding TLS/SSL support
Once you're up and running, you should add TLS/SSL certificates to enable HTTPS. Luckily this is easy, thanks to Let's Encrypt. Run this command, replacing example@protonmail.com with an email you can receive renewal notices on, and example.com with your site.

`docker-compose run --rm certbot certonly --webroot --accept-tos --email example@protonmail.com --webroot-path /var/www/certbot/ -d example.com`

Update frontend.env to point to the HTTPS version of your site, then rebuild the frontend:
```
docker run --rm \
  -v "$(pwd)"/frontend.env:/opt/torrust/torrust/frontend/.env \
  -v "$(pwd)"/data/frontend/dist:/opt/torrust/torrust/frontend/dist \
  zorlin/torrust-frontend:latest
```

With that done, you just need to tell Nginx to use your newly created certifiates. Replace the contents of `torrust-frontend/templates/default.conf.template` with this:

```
server {
    if ($host = ${YOUR_DOMAIN}) {
        return 301 https://$host$request_uri;
    }
    listen 80;
    server_name ${YOUR_DOMAIN};
    return 301 https://$host$request_uri;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
}

server {
    listen 443 ssl;
    server_name ${YOUR_DOMAIN};
    ssl_certificate /etc/nginx/ssl/live/${YOUR_DOMAIN}/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/live/${YOUR_DOMAIN}/privkey.pem;

    root /usr/share/nginx/html;
    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://torrust-docker_backend_1:3000/;
    }
}
```

Now reload the service and you should see a working HTTPS site, all running in Docker. Magic!
