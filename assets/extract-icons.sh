#!/bin/bash

set -e

if convert --version 2>/dev/null | grep -q 'ImageMagick 7'; then
  echo "Found ImageMagick v7"
else
  echo "ImageMagick v7 required - install from source if necessary"
  exit 1
fi

cd "$(dirname "$0")"

echo "Extracting single-res icons..."
layer_index=0
identify -verbose MoonShot-icon.xcf | grep '^ *label: ' | sed -e 's/.*label: //' | while read layer_name; do
  if echo "$layer_name" | grep -Pq '^MoonShot \d+'; then
    res=$(echo "$layer_name" | sed -e 's/MoonShot //')
    echo "$layer_index => $layer_name => $res"
    magick "MoonShot-icon.xcf[$layer_index]" "MoonShot-icon-$res.png"
  fi
  layer_index=$((layer_index+1))
done

echo "Creating ico..."
# Some resolutions aren't allowed in ico, so drop those.
ico_sources=$(ls -1 MoonShot-icon-*.png | egrep -v -- '-(512|128|64)\.png')
magick $ico_sources MoonShot-icon.ico

echo "Creating icns..."
# Some resolutions aren't allowed in icns, so drop those.
icns_sources=$(ls -1 MoonShot-icon-*.png | egrep -v -- '-(96|64)\.png')
png2icns MoonShot-icon.icns $icns_sources

echo "Creating Linux zip..."
zip -r9 MoonShot-icon-linux.zip MoonShot-icon-*.png

echo "Installing icons..."
cp MoonShot-icon.icns ../MoonShot.materials/Icon.icns
cp MoonShot-icon.ico ../MoonShot.materials/Icon.ico
cp MoonShot-icon-128.png ../MoonShot.materials/Icon.png
