#!/bin/bash
pushd .
pwd
cd torrust-tracker
pwd
docker build --no-cache -t torrust-tracker .
popd
pwd
