###What is Salt?
SaltStack or Salt is a really awesome collection of tools which help you manage your IT infrastructure. It is able to let you do parallel sys admin stuff on all your nodes (e.g. “manage a large server farm”), it provides Salt States for configuration management and it provides many other features which could and should be used to make life easier.
It is written in Python and uses the ZeroMQ message bus for communication.
In a classic and easy setup, a Salt Master [which is installed on a failover-safe system] sends commands to Salt Minions which have a set of modules in order to carry out the requested actions.
[Salt-Cheetsheet](https://github.com/saltstack/salt/wiki/Cheat-Sheet)

[Salt-Cheetsheet-Blog](http://www.xenuser.org/saltstack-cheat-sheet/)

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
