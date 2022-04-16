FROM alpine:3.15.4 as build

# Install necessary packages
RUN apk add --no-cache git curl rust cargo bash libressl-dev sqlite-dev

# Create torrust folder
RUN mkdir /opt/torrust/
RUN git clone https://github.com/torrust/torrust-tracker.git /opt/torrust/torrust-tracker

# Build torrust-tracker
WORKDIR /opt/torrust/torrust-tracker
RUN cargo build --release

# Now build our real container :)
FROM alpine:3.15.4

# Install necessary packages
RUN apk add --no-cache sqlite-libs libgcc

# Helpful for debugging, disabled for release
RUN apk add --no-cache bash

RUN mkdir -p /opt/torrust/torrust-tracker/target/release

COPY --from=build /opt/torrust/torrust-tracker/target/release/torrust-tracker /opt/torrust/torrust-tracker/target/release/torrust-tracker

# Install scripts
RUN mkdir /removeme
RUN mkdir /scripts
COPY scripts/ /scripts
RUN chmod +x /scripts/entry.sh

# Switch to tracker dir
WORKDIR /opt/torrust/torrust-tracker

ENTRYPOINT ["/scripts/entry.sh"]
