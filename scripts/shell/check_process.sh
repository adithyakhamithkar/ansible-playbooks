#!/usr/bin/bash
pid=`ps ax | grep -i 'nginx' | grep -v grep | awk '{print $1}'`
if [ -n "$pid" ]
  then
  echo "Nginx is Running as PID: $pid"
else
  echo "Nginx is not Running"
fi
