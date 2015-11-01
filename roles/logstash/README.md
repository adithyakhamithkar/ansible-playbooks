###Create ssl certificate
```
cd /etc/pki/tls
sudo openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
```

###Test logstash configuration
```
opt/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf -t
```

###Set replica shards as 0
```
curl -XPUT 'localhost:9200/_settings' -d '{"index" : {"number_of_replicas" : 0} }’
```
