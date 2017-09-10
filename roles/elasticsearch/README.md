# Elasticsearch
```
dependencies: jdk
```
#### Notes:
```
Stop/Start a node
/etc/init.d/elasticsearch stop/start

Check status of cluster
curl 'http://localhost:9200/_cluster/health?pretty=true'

Watch
watch curl -s 'http://localhost:9200/_cluster/health?pretty=true'

Get index level cluster-health
curl 'http://localhost:9200/_cluster/health?level=indices&pretty=true'

Get Cluster Settings
curl 'localhost:9200/_cluster/settings?pretty=true'

Get Cluster State
curl 'localhost:9200/_cluster/settings?pretty=true'

Get Thread Pool info for cluster
curl 'localhost:9200/_cat/thread_pool?v'

Get cluster allocation (disk allocation, shards etc.,)
curl -s 'localhost:9200/_cat/allocation?v' | sort -rnk2

Get node info, like uptime and other node specific info
curl 'localhost:9200/_cat/nodes?v&h=h,name,uptime,version'

Get all indices on this cluster
curl 'http://localhost:9200/_cat/indices?pretty

Get list of unassigned shard
curl 'localhost:9200/_cat/shards?v' | grep UNASSIGNED

Get list of all indices with size
curl 'localhost:9200/_cat/indices?v&h=index,store.size'

Delete an indic
curl -XDELETE 'http://localhost:9200/twitter/'

curl -XGET 'http://localhost:9200/_cluster/pending_tasks'

curl -XPUT 'localhost:9200/<index>/_settings' -d '{
    "index" : {
        "number_of_replicas" : 1
     }
}'
```

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
ht_elasticsearch_url="{{ groups['elasticsearch-master'] | map('extract', hostvars, ['ansible_ssh_host']) | join(':9200,') }}:9200"
ht_data_nodes_ips="{{ groups['elasticsearch-data'] | map('extract', hostvars, ['ansible_ssh_host']) | join('\n') }}"

[elasticsearch-master]
elasticsearch-master-01 ansible_ssh_host=192.168.33.10 hostname=elasticsearch-master-01

[elasticsearch-data]
elasticsearch-data-01 ansible_ssh_host=192.168.33.11 hostname=elasticsearch-data-01
elasticsearch-data-02 ansible_ssh_host=192.168.33.12 hostname=elasticsearch-data-02
```
