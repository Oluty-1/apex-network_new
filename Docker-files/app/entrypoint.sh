#!/bin/sh

# Parse APP_CONFIG and export variables
if [ ! -z "$APP_CONFIG" ]; then
    eval $(echo $APP_CONFIG | jq -r 'to_entries | map("export " + .key + "=\"" + (.value | tostring) + "\"") | .[]')
fi

# Execute the main application
exec ./apex_network apex_network_api