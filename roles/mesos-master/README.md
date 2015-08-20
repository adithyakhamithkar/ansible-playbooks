##What is Mesos?
+ At a high level Mesos is a cluster management platform which enables building resource-efficient distributed systems
Mesos provides efficient dynamic resource isolation and sharing across multiple distributed applications (including, for example, Hadoop, Spark and Memcache)
+ Mesos provides efficient dynamic resource isolation and sharing across multiple distributed applications (including, for example, Hadoop, Spark and Memcache)

###Note:
This role requires a mesos installation, as this will only configure mesos as a master.

###Depandancies
- zookeeper
- mesos

###Example hosts configuration
```
[mesos:children]
mesos-master
mesos-slave

[mesos:vars]
mesos_cluster_name=Mymesos
zk_mesos_string=zk://192.168.44.182:2181,192.168.44.183:2181,192.168.44.184:2181/mesos
zk_marathon_string=zk://192.168.44.182:2181,192.168.44.183:2181,192.168.44.184:2181/marathon
zookeeper1=192.168.44.182
zookeeper2=192.168.44.183
zookeeper3=192.168.44.184

[mesos-master]
mesos-master-1 ansible_ssh_host=192.168.44.182 hostname=mesos-master-1 zookeeper_id=1
mesos-master-2 ansible_ssh_host=192.168.44.183 hostname=mesos-master-2 zookeeper_id=2
mesos-master-3 ansible_ssh_host=192.168.44.184 hostname=mesos-master-3 zookeeper_id=3

[mesos-slave]
mesos-slave-1 ansible_ssh_host=192.168.44.185 hostname=mesos-slave-1
```
