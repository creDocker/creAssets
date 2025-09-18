#!/bin/bash

#CRE_SECRET_PW='secret'

mkdir -p /cre/assets/private/
#decrypt
if [ ! -z "${CRE_SECRET_PW}" ]; then
 gpg --batch --output /cre/secrets/mapglyphs.zip --passphrase $CRE_SECRET_PW --decrypt /cre/secrets/mapglyphs.zip.gpg
 unzip -P $CRE_SECRET_PW /cre/secrets/mapglyphs.zip -d /cre/assets/private/mapglyphs
 #rm -f /cre/secrets/mapglyphs.zip.gpg
 #rm -f /cre/secrets/mapglyphs.zip
fi
