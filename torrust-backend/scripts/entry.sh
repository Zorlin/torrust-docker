#!/bin/bash

#if [ $1 == "create-config" ]
#then
#	echo "Creating configuration file."
#	/opt/torrust/torrust-tracker/target/release/torrust-tracker
#        cat config.toml
#fi

if [ ! -f "/opt/torrust/torrust-tracker/config.toml" ]; then
	# Create configuration file by calling torrust-tracker, but don't collect any logging output.
	/opt/torrust/torrust-tracker/target/release/torrust-tracker &> /dev/null
	# Print the config file.
	cat config.toml
else
	# Run torrust-tracker
	/opt/torrust/torrust-tracker/target/release/torrust-tracker
fi
