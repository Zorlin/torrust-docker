FROM ubuntu:focal as build

# Install necessary packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git curl bash libssl-dev libsqlite3-dev build-essential pkg-config openssl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Create torrust folder
RUN mkdir /opt/torrust/
RUN git clone https://github.com/torrust/torrust.git /opt/torrust/torrust
# Set database path
RUN echo "DATABASE_URL=sqlite://data.db?mode=rwc" > /opt/torrust/torrust/backend/.env

# Switch to backend dir
WORKDIR /opt/torrust/torrust/backend

# Create dummy database data
RUN . "$HOME/.cargo/env" && cargo install sqlx-cli
RUN . "$HOME/.cargo/env" && /root/.cargo/bin/sqlx db setup

# Build torrust-tracker
RUN . "$HOME/.cargo/env" && cargo build --release

# Now build our real container :)
FROM ubuntu:focal

# Install necessary packages
RUN apt-get update && apt-get install -y sqlite3 libssl-dev

# Helpful for debugging, disabled for release

RUN mkdir -p /opt/torrust/torrust/backend/target/release

COPY --from=build /opt/torrust/torrust/backend/target/release/torrust /opt/torrust/torrust/backend/target/release/torrust
COPY --from=build /opt/torrust/torrust/backend/data.db /opt/torrust/torrust/backend/db/data.db

# Install scripts
RUN mkdir /scripts
COPY scripts/ /scripts
RUN chmod +x /scripts/entry.sh

# Switch to backend dir
WORKDIR /opt/torrust/torrust/backend

ENTRYPOINT ["/scripts/entry.sh"]
