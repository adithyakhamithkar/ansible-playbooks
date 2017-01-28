###Galera Cluster is for mysql replication

https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mysql-5-6-on-ubuntu-16-04

###Example hosts
```
[test]
test-box   ansible_ssh_host=192.168.33.10 hostname=test-box   mysql_primary=primary
test-box1  ansible_ssh_host=192.168.33.11 hostname=test-box1
test-box2  ansible_ssh_host=192.168.33.12 hostname=test-box2

[test:vars]
cluster_name=test_cluster
cluster_address=gcomm://192.168.33.10,192.168.33.11,192.168.33.12
```
####To connect to the cluster
```
garbd –a gcomm://192.168.33.10,192.168.33.11,192.168.33.12 –g cluster_name
```
