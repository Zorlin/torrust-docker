FROM alpine:3.15.4

# Install necessary packages
RUN apk add --no-cache git bash nodejs npm

# Create torrust folder
RUN mkdir /opt/torrust/
RUN git clone https://github.com/torrust/torrust.git /opt/torrust/torrust

# Install scripts
RUN mkdir /scripts
COPY scripts/ /scripts
RUN chmod +x /scripts/entry.sh

# Run the entry script to build the frontend
ENTRYPOINT ["/scripts/entry.sh"]
CMD ["build"]
