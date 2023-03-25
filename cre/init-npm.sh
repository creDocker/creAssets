#!/bin/bash



#/cre/node/.npm-global/lib   -> tools, etc
#/cre/node                   -> local, current     package-lock.json
#/cre/versions/              -> local, specific    package-lock_2020.json

#/cre/assets/...             -> dist only js,css, etc...

##TODO
##if exists package.2020.json then copy to node package.json
##if exists /cre/assets/package.*.json then copy to node
##(else use current)
##npm install
##copy dist/* to assets.

##Here: cp package.json and package.lock.json to /cre/assets

currentRoot=""
if [ ! -z $GITHUB_REPOSITORY ]; then
    currentRoot="$(pwd)"
fi
packageFile="$currentRoot/cre/versions/u$UBUNTU_VERSION/package.json"  
lockFile="$currentRoot/cre/versions/u$UBUNTU_VERSION/package.lock.json"
publicAssets="$currentRoot/cre/versions/u$UBUNTU_VERSION/assets/public/"

if [ -f $packageFile ]; then
    cp -f $packageFile /cre/node/package.json
    if [ -f $lockFile ]; then
        cp -f $lockFile /cre/node/package.lock.json
    fi
fi

#may better merge in if possible
if [ -f /cre/assets/package.json ]; then
    cp -f /cre/assets/package.json /cre/node/package.json
    if [ -f /cre/assets/package.lock.json ]; then
        cp -f /cre/assets/package.lock.json /cre/node/package.lock.json
    fi
fi

cd "/cre/node"
npm install

##copy dist/* to assets.
mkdir -p /cre/assets/public/jquery/js
cp -f /cre/node/node_modules/jquery/dist/*.* /cre/assets/public/jquery/js
mkdir -p /cre/assets/public/ol/js
cp -f /cre/node/node_modules/ol/dist/*.* /cre/assets/public/ol/js
mkdir -p /cre/assets/public/ol/css
cp -f /cre/node/node_modules/ol/*.css /cre/assets/public/ol/css
## mkdir -p /cre/assets/private/mapglyph

if [ -f /cre/node/package.json ]; then
    cp -f /cre/node/package.json /cre/assets/package.json
    if [ -f /cre/node/package.lock.json ]; then
        cp -f /cre/node/package.lock.json /cre/assets/package.lock.json
    fi
fi

##(In version, cp package.json to u<version> and submit)
##(In version, cp /cre/assets/public/ to u<version> and submit)
if [ ! -z $GITHUB_REPOSITORY ]; then
    #only once!
    if [ ! -f $packageFile ]; then
        cp -f /cre/node/package.json $packageFile
    fi
    if [ ! -f $lockFile ]; then
        cp -f /cre/node/package.lock.json $lockFile
    fi 
    #always
    cp -R -f /cre/assets/public/ $publicAssets
fi

cd "/cre/assets"



