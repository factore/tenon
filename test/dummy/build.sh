#!/bin/bash

mkdir -p public/assets
rm -f public/assets/*.chunk.*

npm run build

mv client/build/assets/*.chunk.* public/assets/

RAILS_ENV=production rake assets:precompile

rm -rf client/build/assets
rm -f client/build/stats.json

