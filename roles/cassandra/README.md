###Example hosts configuration
```
[cassandra]
cassandra-seed-1 ansible_ssh_host=192.168.44.201 hostname=cassandra-seed-1
cassandra-seed-2 ansible_ssh_host=192.168.44.200 hostname=cassandra-seed-2
cassandra-data-1 ansible_ssh_host=192.168.44.199 hostname=cassandra-data-1

[cassandra:vars]
cassandra_cluster_name=My Cluster
cassandra_seeds=192.168.44.201,192.168.44.200
cassandra_data=/mnt
```
