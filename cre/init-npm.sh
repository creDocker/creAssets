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

# sudo docker run credocker/creassets:2024.0  ls -l /cre/node/node_modules/

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


mkdir -p /cre/assets/public/d3/js
mkdir -p /cre/assets/public/d3/css
cp -f /cre/node/node_modules/d3/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3/dist/*.js /cre/assets/public/d3/js
# d3-array ... d3-zoom 
cp -f /cre/node/node_modules/d3-array/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-axis/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-brush/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-chord/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-collection/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-color/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-contour/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-delaunay/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-dispatch/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-drag/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-dsv/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-ease/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-fetch/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-force/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-format/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-geo/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-hierarchy/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-interpolate/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-path/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-polygon/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-quadtree/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-random/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-scale/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-scale-chromatic/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-selection/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-shape/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-time/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-time-format/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-timer/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-transition/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-voronoi/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/d3-zoom/dist/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/c3/*.js /cre/assets/public/d3/js
cp -f /cre/node/node_modules/c3/*.css /cre/assets/public/d3/css

mkdir -p /cre/assets/public/three/js
mkdir -p /cre/assets/public/three/images
cp -f /cre/node/node_modules/three/build/*.js /cre/assets/public/three/js
cp -f /cre/extra/js/globe.js /cre/assets/public/three/js
cp -f /cre/extra/js/TrackballControls.js /cre/assets/public/three/js
cp -f /cre/extra/images/earth*1k.jpg /cre/assets/public/three/images

mkdir -p /cre/assets/public/openseadragon/js
mkdir -p /cre/assets/public/openseadragon/images
cp -f /cre/node/node_modules/openseadragon/build/openseadragon/*.js /cre/assets/public/openseadragon/js
cp -f /cre/node/node_modules/openseadragon/build/openseadragon/images/*.png /cre/assets/public/openseadragon/images

## NOT WORKING !?!
ls -l /cre/node/node_modules/
ls -l /cre/node/node_modules/gl-transitions/
mkdir -p /cre/assets/public/gl-slideshow/js
mkdir -p /cre/assets/public/gl-slideshow/css
mkdir -p /cre/assets/public/gl-slideshow/transitions
cp -f /cre/node/node_modules/gl-transitions/*.js /cre/assets/public/gl-slideshow/js
cp -f /cre/node/node_modules/gl-transitions/transitions/*.glsl /cre/assets/public/gl-slideshow/transitions
cp -f /cre/node/node_modules/GLSlideshow/dist/*.js /cre/assets/public/gl-slideshow/js


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



