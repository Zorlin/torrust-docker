#!/bin/bash

if [ ! -f "/opt/torrust/torrust-tracker/config.toml" ]; then
	# Create configuration file by calling torrust-tracker, but don't collect any logging output.
	/opt/torrust/torrust-tracker/target/release/torrust-tracker &> /dev/null
	# Print the config file.
	cat config.toml
else
	cd /opt/torrust/torrust-tracker
	# Run torrust-tracker
	/opt/torrust/torrust-tracker/target/release/torrust-tracker
fi
