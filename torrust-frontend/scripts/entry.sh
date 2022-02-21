#!/bin/bash

if [ $1 == "build" ]; then
	cd /opt/torrust/torrust/frontend
	npm i
	npm run build
	echo == DEBUG OUTPUT ==
        cat /opt/torrust/torrust/frontend/.env
fi
