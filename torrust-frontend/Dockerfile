FROM alpine:3.14 as build

# Install necessary packages
RUN apk add --no-cache git bash nodejs npm

# Create torrust folder
RUN mkdir /opt/torrust/
RUN git clone https://github.com/torrust/torrust.git /opt/torrust/torrust
# Set frontend path
COPY .env /opt/torrust/torrust/frontend/.env

# Switch to backend dir
WORKDIR /opt/torrust/torrust/frontend

# Build torrust-frontend
RUN npm i
RUN npm run build

# Now build our real container :)
FROM alpine:3.14

RUN mkdir /opt/torrust/torrust/frontend
COPY --from=build /opt/torrust/torrust/frontend/dist /opt/torrust/torrust/frontend/dist

# Install scripts
RUN mkdir /scripts
COPY scripts/ /scripts
RUN chmod +x /scripts/entry.sh

ENTRYPOINT ["/scripts/entry.sh"]
CMD ["create-config"]
