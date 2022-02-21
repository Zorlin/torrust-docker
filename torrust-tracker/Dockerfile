FROM alpine:3.14

# Install necessary packages
RUN apk add --no-cache git curl rust cargo bash libressl-dev sqlite-dev

# Create torrust folder
RUN mkdir /opt/torrust/
RUN git clone https://github.com/torrust/torrust-tracker.git /opt/torrust/torrust-tracker

# Build torrust
WORKDIR /opt/torrust/torrust-tracker
RUN cargo build --release

# Install scripts
RUN mkdir /scripts
COPY scripts/ /scripts
RUN chmod +x /scripts/entry.sh

ENTRYPOINT ["/scripts/entry.sh"]
CMD ["create-config"]
