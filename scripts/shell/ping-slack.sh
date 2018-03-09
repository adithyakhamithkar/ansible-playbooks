#/bin/bash
channel=$1
message=$2
username=$3
token=$4

curl -X POST --data-urlencode "payload={\"channel\": \"#$channel\", \"username\": \"$username\", \"text\": \"$message\", \"icon_emoji\": \":ghost:\"}'" https://hooks.slack.com/services/$token
