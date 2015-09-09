###Note: Requires a salt-master
###Hosts example:
```
[saltstack]
salt-master ansible_ssh_host=192.168.44.193 hostname=salt-master
salt-minion ansible_ssh_host=192.168.44.194 hostname=salt-minion

[saltstack:vars]
salt_master=192.168.44.193
```
###Vars example
```
###SaltStack
salt_pem : inventory/test-env/keys/salt.pem
salt_pub : inventory/test-env/keys/salt.pub
```
