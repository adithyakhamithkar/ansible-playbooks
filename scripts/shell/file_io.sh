#!/usr/bin/bash
file_path=$1

while read -r line || [[ -n $line ]]; do
  IFS=':' read -a myarray <<< "$line"
  echo user_name=${myarray[0]}
  echo email_id=${myarray[1]}
done < $file_path
