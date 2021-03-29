#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Fresh checkout 
rm -Rf janus-gateway
git clone --depth=1 -q https://github.com/meetecho/janus-gateway.git

# Move only the required files
mkdir -p html
cp janus-gateway/package.json . 
cp janus-gateway/html/janus.js html/janus.js

# Replace it with our name
sed -i '' 's/"name": "janus-gateway"/"name": "janus-gateway-mirror"/g' package.json

# Continue with release
cat package.json
read -p "Does this release look good? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    npm publish
fi

