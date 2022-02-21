FROM alpine:3.14 as build

# Install necessary packages
#RUN apk add --no-cache git curl rust cargo bash libressl-dev sqlite-dev
# Install rust via rustup instead of apk as the apk version is too old.
RUN apk add --no-cache git curl bash libressl-dev sqlite-dev libgcc build-base
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# Install libc6-compat so sqlx will run without a not found error :)
RUN apk add libc6-compat

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

ENTRYPOINT ["/bin/bash"]
