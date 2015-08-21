##What is Kafka?
Apache Kafka is an open-source message broker project developed by the Apache Software Foundation written in Scala. The project aims to provide a unified, high-throughput, low-latency platform for handling real-time data feeds.

###Depandancies
- jdk
- zookeeper
- scala
- kafka

###Variables
```
kafka_url : http://mirror.cc.columbia.edu/pub/software/apache/kafka/0.8.2.1/kafka_2.11-0.8.2.1.tgz
```

###Example hosts configuration
```
[kafka]
kafka-01 ansible_ssh_host=192.168.44.190 hostname=kafka-01 zookeeper_id=1
kafka-02 ansible_ssh_host=192.168.44.191 hostname=kafka-02 zookeeper_id=2
kafka-03 ansible_ssh_host=192.168.44.192 hostname=kafka-03 zookeeper_id=3

[kafka:vars]
zookeeper1=192.168.44.190
zookeeper2=192.168.44.191
zookeeper3=192.168.44.192
zk_kafka_string=192.168.44.190:2181,192.168.44.191:2181,192.168.44.192:2181/kafka
```
