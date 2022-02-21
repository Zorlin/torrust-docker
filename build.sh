#!/bin/bash
pushd .
pwd
cd torrust-tracker
pwd
docker build -t torrust-tracker .
popd
pwd
