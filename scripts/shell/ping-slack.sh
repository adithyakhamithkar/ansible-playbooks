#/bin/bash
channel=$1
token=$2

curl -X POST --data-urlencode "payload={\"channel\": \"#$channel\", \"username\": \"webhookbot\", \"text\": \"This is posted to #general and comes from a bot named webhookbot.\", \"icon_emoji\": \":ghost:\"}'" https://hooks.slack.com/services/$token
