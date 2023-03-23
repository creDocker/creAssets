#!/bin/bash

cd "/cre/node"


#/cre/node/.npm-global/lib   -> tools, etc
#/cre/node                   -> local, current     package-lock.json
#/cre/versions/              -> local, specific    package-lock_2020.json

#/cre/assets/...             -> dist only js,css, etc...

##TODO
##if exists package.2020.json then copy to node package.json
##if exists /cre/assets/package.*.json thn copy to node
##(else use current)
##npm install
##copy dist/* to assets.
##(In version, cp package.json to package.2020.json and submit)
##Here: cp package.json and package.lock.json to /cre/assets

########### FROM PYTHON
# Creates requirements.txt

if [ ! -f /cre/python/requirements.txt ]; then
    pip freeze > /cre/python/requirements.txt
    chmod 777 /cre/python/requirements.txt
fi

# https://github.com/bndr/pipreqs

pipreqs --mode gt --force /cre/python/

# Install
pip install -r /cre/python/requirements.txt

# Initialize
if [ -f /cre/python/initialize.sh ]; then
    chmod 777 /cre/python/initialize.sh
    /cre/python/initialize.sh
fi
#################


cd "/cre/assets"



