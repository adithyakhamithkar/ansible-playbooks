###Variables
```
hadoop_url : http://www.us.apache.org/dist/hadoop/common/hadoop-2.6.3/hadoop-2.6.3.tar.gz
```

###Example hosts configuration
```
[hadoop:children]
hadoop-master
hadoop-slave

[hadoop:vars]

[hadoop-master]
hadoop-master ansible_ssh_host=192.168.44.200 hostname=hadoop-master

[hadoop-master:vars]

[hadoop-slave]
hadoop-slave-1 ansible_ssh_host=192.168.44.201 hostname=hadoop-slave-1

[hadoop-slave:vars]
```
