#!/usr/bin/env sh

set -e

#npm run build

cd dist

#git init
git add -A
git commit -m 'push'
git push -f git@github.com:prkince/game-vuejs master:gh-pages

cd -
