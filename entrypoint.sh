#!/bin/sh

# Parse APP_CONFIG and export variables
eval $(echo $APP_CONFIG | jq -r 'to_entries | map("export " + .key + "=\"" + (.value | tostring) + "\"") | .[]')

# Execute the main application
exec ./apex_network apex_network_api

# # Parse APP_CONFIG and set environment variables
# eval $(echo $APP_CONFIG | jq -r 'to_entries | .[] | "export \(.key)=\(.value)"')

# # Run the main application
# exec "$@"