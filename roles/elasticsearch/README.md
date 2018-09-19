# Elasticsearch
```
dependencies: jdk
```
#### Notes:
```
Stop/Start a node
/etc/init.d/elasticsearch stop/start

Check status of cluster
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cluster/health?pretty=true'

Watch
watch curl -s -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cluster/health?pretty=true'

Get index level cluster-health
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cluster/health?level=indices&pretty=true'

Get Cluster Settings
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cluster/settings?pretty=true'

Get Thread Pool info for cluster
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cat/thread_pool?v'

Get cluster allocation (disk allocation, shards etc.,)
curl -s -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cat/allocation?v' | sort -rnk2

Get node info, like uptime and other node specific info
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cat/nodes?v&h=h,name,uptime,version'

Get all indices on this cluster
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cat/indices?pretty'

Get list of unassigned shard
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cat/shards?v' | grep UNASSIGNED

Get list of all indices with size
curl -XGET -H 'Content-Type: application/json' 'http://localhost:9200/_cat/indices?v&h=index,store.size'

Delete an indic
curl -XDELETE -H 'Content-Type: application/json' 'http://localhost:9200/<index_name>/'

Close an index
curl -XPOST -H 'Content-Type: application/json' 'http://localhost:9200/<index_name>/_close'

curl -XGET -H 'Content-Type: application/json 'http://localhost:9200/_cluster/pending_tasks'

curl -XPUT -H 'Content-Type: application/json' 'http://localhost:9200/<index>/_settings' -d '{
    "index" : {
        "number_of_shards" : 1,
        "number_of_replicas" : 0
     }
}'

To make setting permanent
curl -XPUT -H 'Content-Type: application/json' 'http://localhost:9200/_template/priority1' -d '
{
"template" : "*",
"settings" : { "number_of_replicas" : 0 }
}'

Import a json file
curl -XPUT 'Content-Type: application/json' 'http://localhost:9200/<index_name>' --data-binary @file_name.json
curl -XPOST 'Content-Type: application/json' 'http://localhost:9200/<index_name>/_bulk' --data-binary @file_name.json

Search query
curl -H 'Content-Type: application/json' -XGET 'http://localhost:9200/<index>/_search?pretty' -d '
{
"query" : {

  }
}'

curl -H 'Content-Type: application/json' -XGET 'http://localhost:9200/<index_name>/<doc_type>/_search?pretty' -d '
{
  "query":
     {
        "query_string" :
          {
                "query" : ""
           }
      }
}'

Take a backup
curl -XPUT 'http://localhost:9200/_snapshot/elasticsearch-backup/snapshot-1?pretty' -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/mnt1/elasticsearch-backup"
  }
}'

Check backup
curl -XGET 'http://localhost:9200/_snapshot/elasticsearch-backup/snapshot-1?pretty' -H 'Content-Type: application/json'

Monitor backup status
curl -XGET 'http://localhost:9200/_snapshot/elasticsearch-backup/snapshot-1/_status?pretty' -H 'Content-Type: application/json'

Restore a backup for all indices
First close all indices
curl -XPOST 'http://localhost:9200/_all/_close?pretty' -H 'Content-Type: application/json'
Restore
curl -XPOST 'http://localhost:9200/_snapshot/elasticsearch-backup/snapshot-1/_restore?pretty' -H 'Content-Type: application/json'

```
Types of filters
`term` filters by exact value
```
{"term":{"year":2014}}

```
`terms` match if any exact values in a list of match
```
{"terms":{"genre":["Sci-Fi","Adventure"]}}}
```
`range` finds numbers or date in a given range(gt, gte, lt, lte)
```
{"range":{"year: {"gte":2010}"}}
```
`exists` find documents where a filed exists
```
{"exists":{"field":"tags"}}
```
`missing` find documents where a field is missing
```
{"missing":{"filed":"tags"}}
```
`bool` combine filters with boolean logic(must, must_name, should)

types of queries
`match_all` returns all documents and is the default. Normall used with a filter
```
{"match_all":{}}
```
`match` searches analyzed results such as full text search
```
{"match":{"title":"star"}}
```
`multi_match` run the same query on multiple fiends
```
{"multi_match":{"query":"star","fields":["title","synopsis"]}}
```
`bool` works like a book filter, but results are scored by relevance


#### Example hosts:
```
[elasticsearch:children]
elasticsearch-master
elasticsearch-data

[elasticsearch:vars]
ht_cluster_name=elasticsearch
ht_data_path=/mnt1/elasticsearch-data
ht_logs_path=/logs/elasticsearch-logs
ht_xms=1g
ht_xmx=1g
ht_master_nodes_ips="{{ groups['elasticsearch-master'] | map('extract', hostvars, ['ansible_ssh_host']) | join(',') }}"
ht_master_nodes_ips_with_port="{{ groups['elasticsearch-master'] | map('extract', hostvars, ['ansible_ssh_host']) | join(':9300,') }}:9300"
ht_elasticsearch_url="http://{{ groups['elasticsearch-master'] | map('extract', hostvars, ['ansible_ssh_host']) | join(':9200,') }}:9200"
ht_data_nodes_ips="{{ groups['elasticsearch-data'] | map('extract', hostvars, ['ansible_ssh_host']) | join('\n') }}"

[elasticsearch-master]
elasticsearch-master-01 ansible_ssh_host=192.168.33.10 hostname=elasticsearch-master-01

[elasticsearch-data]
elasticsearch-data-01 ansible_ssh_host=192.168.33.11 hostname=elasticsearch-data-01
elasticsearch-data-02 ansible_ssh_host=192.168.33.12 hostname=elasticsearch-data-02
```


```
curl -XGET localhost:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason| grep UNASSIGNED
```

Force assign shards
```
curl -q -s "http://localhost:9200/_cat/shards" | egrep "UNASSIGNED" | while read index shard type state; do if [ $type = "r" ]; then curl -X POST "http://localhost:9200/_cluster/reroute" -d "{ \"commands\" : [ { \"allocate_replica\": { \"index\": \"$index\", \"shard\": $shard, \"node\": \"node_name\" } } ] }"; fi; done

 curl -q -s "http://localhost:9200/_cat/shards" | egrep "UNASSIGNED" | while read index shard type state; do if [ $type = "p" ]; then curl -X POST "http://localhost:9200/_cluster/reroute" -d "{ \"commands\" : [ { \"allocate_stale_primary\": { \"index\": \"$index\", \"shard\": $shard, \"node\": \"node_name\", \"accept_data_loss\": true } } ] }"; fi; done
 ```

Get list of closed indices
```
curl -s -XGET 'http://localhost:9200/_cat/indices?h=status,index' | awk '$1 == "close" {print $2}'
```

curl -s -XGET 'http://localhost:9200/_cat/indices?h=status,index' | awk '$1 == "close" {print $2}'
