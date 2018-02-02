#/bin/bash
channel=$1
token=$2

escapedText="I am pinging `echo $channel `"

json="{\"channel\": \"#$channel\", \"text\": \"$escapedText\", \"username\": \"Boo\", \"icon_emoji\": \":ghost:\"}"

curl -X POST --data-urlencode "payload=$json"  https://hooks.slack.com/services/$token
