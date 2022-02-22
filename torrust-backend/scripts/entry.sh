#!/bin/bash

if [ ! -f "/opt/torrust/torrust/backend/db/config.toml" ]; then
	# Create configuration file by calling torrust-tracker, but don't collect any logging output.
	/opt/torrust/torrust/backend/target/release/torrust &> /dev/null
	# Print the config file.
	cat config.toml
else
	echo '/tmp/core.%h.%e.%t' > /proc/sys/kernel/core_pattern
	ulimit -c unlimited
	# Change directory
        cd /opt/torrust/torrust/backend/db
	ls /opt/torrust/torrust/backend/target/release/torrust
	# Run torrust-tracker
	/opt/torrust/torrust/backend/target/release/torrust
fi
