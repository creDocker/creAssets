#!/bin/bash
sleep 1

#/cre/node/.npm-global/lib   -> tools, etc
#/cre/node                   -> local, current     package-lock.json
#/cre/versions/u<version>    -> local, specific    package-lock_2020.json

#
#/cre/assets/public/...             -> dist only js,css, etc...
#/cre/assets/private/..             -> dist only js,css, etc...

currentRoot=""
if [ ! -z $GITHUB_REPOSITORY ]; then
    currentRoot="$(pwd)"
    echo "current root: $currentRoot"
fi
packageFile="$currentRoot/cre/versions/u$UBUNTU_VERSION/package.json"  
lockFile="$currentRoot/cre/versions/u$UBUNTU_VERSION/package-lock.json"
publicAssets="$currentRoot/cre/versions/u$UBUNTU_VERSION/assets/"

if [ -f $packageFile ]; then
    cp -f $packageFile /cre/node/package.json
    if [ -f $lockFile ]; then
        cp -f $lockFile /cre/node/package-lock.json
    fi
fi

#may better merge in if possible
if [ -f /cre/assets/package.json ]; then
    cp -f /cre/assets/package.json /cre/node/package.json
    if [ -f /cre/assets/package-lock.json ]; then
        cp -f /cre/assets/package-lock.json /cre/node/package-lock.json
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

mkdir -p /cre/assets/public/vue/js
cp -f /cre/node/node_modules/vue/dist/vue.global.js /cre/assets/public/vue/js
cp -f /cre/node/node_modules/vuex/dist/vuex.global.js /cre/assets/public/vue/js
cp -f /cre/node/node_modules/axios/dist/axios.* /cre/assets/public/vue/js

mkdir -p /cre/assets/public/bootstrap/js
cp -f /cre/node/node_modules/bootstrap/dist/js/bootstrap.js /cre/assets/public/bootstrap/js
cp -f /cre/node/node_modules/bootstrap/dist/js/bootstrap.min.js /cre/assets/public/bootstrap/js
cp -f /cre/node/node_modules/bootstrap/dist/js/bootstrap.js.map /cre/assets/public/bootstrap/js
mkdir -p /cre/assets/public/bootstrap/css
cp -f /cre/node/node_modules/bootstrap/dist/css/bootstrap.min.css /cre/assets/public/bootstrap/css
cp -f /cre/node/node_modules/bootstrap/dist/css/bootstrap.css /cre/assets/public/bootstrap/css
cp -f /cre/node/node_modules/bootstrap/dist/css/bootstrap.min.css.map /cre/assets/public/bootstrap/css
cp -f /cre/extra/css/*.css /cre/assets/public/bootstrap/css

mkdir -p /cre/assets/public/jszip/js
cp -f /cre/node/node_modules/jszip/dist/*.* /cre/assets/public/jszip/js

mkdir -p /cre/assets/public/jspdf/js
cp -f /cre/node/node_modules/jspdf/dist/*.* /cre/assets/public/jspdf/js



## mkdir -p /cre/assets/private/mapglyph

if [ -f /cre/node/package.json ]; then
    cp -f /cre/node/package.json /cre/assets/package.json
    if [ -f /cre/node/package-lock.json ]; then
        cp -f /cre/node/package-lock.json /cre/assets/package-lock.json
    fi
fi

##(In version, cp package.json to u<version> and submit)
##(In version, cp /cre/assets/public/ to u<version> and submit)
if [ ! -z $GITHUB_REPOSITORY ]; then
    mkdir -p $publicAssets
    #only once!
    if [ ! -f $packageFile ]; then
        cp -f /cre/node/package.json $packageFile
    fi
    if [ ! -f $lockFile ]; then
        cp -f /cre/node/package-lock.json $lockFile
    fi 
    #always
    cp -R -f /cre/assets/public/ $publicAssets
fi

cd "/cre/assets"



