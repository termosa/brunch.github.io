#!/usr/bin/env bash
set -o pipefail

echo "$TRAVIS_BRANCH"

if [ "$TRAVIS_BRANCH" = "source" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]
then
  echo "Deploying!"
  npm run prod
  cd public
  git config --global user.email "travis@brunch.io"
  git config --global user.name "TRAVIS-CI"
  git init
  git add .
  git commit -m "deploy"
  git push --force "https://${GH_TOKEN}@github.com/brunch/brunch.github.io.git" master
else
  npm run prod
fi