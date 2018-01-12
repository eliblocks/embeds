#!/bin/bash

# Source: http://blog.nonuby.com/blog/2012/07/05/copying-env-vars-from-one-heroku-app-to-another/

set -e

sourceApp="embeds"
targetApp="embeds-staging"

defaultKeys=(DATABASE_URL PAPERTRAIL_API_TOKEN ROLLBAR_ACCESS_TOKEN ROLLBAR_ENDPOINT CLOUDFRONT_PRIVATE_KEY)
while read key value; do
  key=${key%%:}
  if [[ ${defaultKeys[*]} =~ $key ]];
    then
      echo "Ignoring $key=$value"
    else
      echo "Setting $key=$value"
      heroku config:set "$key=$value" --app "$targetApp"
  fi
done  < <(heroku config --app "$sourceApp" | sed -e '1d')