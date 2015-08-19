##What is ZooKeeper?
ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications.

###Variable format
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
