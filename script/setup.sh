#!/bin/sh

set -e

echo "Installing gems at GEM_PATH $GEM_PATH"
echo "Installing gems with bundler at BUNDLE_PATH $BUNDLE_PATH"

gem install bundler

rm -f tmp/pids/server.pid

bundle check || bundle install --jobs 2

bundle exec rails server -p 3000 -b 0.0.0.0
