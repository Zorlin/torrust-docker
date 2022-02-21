#!/bin/bash

if [ ! -f "/opt/torrust/torrust/backend/config.toml" ]; then
	# Create configuration file by calling torrust-tracker, but don't collect any logging output.
	/opt/torrust/torrust/backend/target/release/torrust &> /dev/null
	# Print the config file.
	cat config.toml
else
	# Run torrust-tracker
	/opt/torrust/torrust/backend/target/release/torrust
fi
