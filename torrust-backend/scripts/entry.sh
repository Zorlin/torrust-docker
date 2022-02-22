#!/bin/bash

if [ ! -f "/opt/torrust/torrust/backend/config.toml" ]; then
	# Create configuration file by calling torrust-tracker, but don't collect any logging output.
	/opt/torrust/torrust/backend/target/release/torrust &> /dev/null
	# Print the config file.
	cat config.toml
else
        # Enable core dumps
        echo '/tmp/core.%h.%e.%t' > /proc/sys/kernel/core_pattern
        ulimit -c unlimited
	# Change directory
        cd /opt/torrust/torrust/backend
	# Run torrust-tracker
	/opt/torrust/torrust/backend/target/release/torrust
fi
