###What is Salt?
SaltStack or Salt is a really awesome collection of tools which help you manage your IT infrastructure. It is able to let you do parallel sys admin stuff on all your nodes (e.g. “manage a large server farm”), it provides Salt States for configuration management and it provides many other features which could and should be used to make life easier.
It is written in Python and uses the ZeroMQ message bus for communication.
In a classic and easy setup, a Salt Master [which is installed on a failover-safe system] sends commands to Salt Minions which have a set of modules in order to carry out the requested actions.

[Salt-Cheetsheet](https://github.com/saltstack/salt/wiki/Cheat-Sheet)

[Salt-Cheetsheet-Blog](http://www.xenuser.org/saltstack-cheat-sheet/)

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
###Notes:
Running shell commands:
```
salt '*'  cmd.run 'ps -aux | grep salt'
```
Running a ping:
```
salt '*' test.ping
```
###Useful Salt commands
####Key-Management

Listing all Salt key registration requests
```
salt-key -L
```
Accepting all Salt key requests:
```
salt-key -A
```
Accepting a single Salt key request, where minion_id is the name of the Minion:
```
salt-key -a minion_id
```
Removing the key of a Salt Minion, where minion_id is the name of the Minion:
```
salt-key -d minion_id
```

####Overview of connected Salt Minions

Query Salt in order to find out what Minions are online, offline or maybe even show both :-)
```
salt-run manage.up # Shows what Minions are up
```
```
salt-run manage.down # Shows what Minions are down or not connected
```
```
salt-run manage.status # Shows both online and offline Minions
```
Reach out to all Minions and request a life sign (aka “ping all Salt Minions”). Please note that not a real ping is sent to the Minions; instead, a function is called which simply returns true.
```
salt "*" test.ping
```

Simply target all Salt Minions (hint: use the “*”):
```
salt "*" some_module
```
Target Minions based on their Minion ID (mostly this is the hostname or FQDN):
```
salt "web*" some_module
```
Target Minions based on their characteristics (based on Salt Grains which are invoked via “-G”), e.g. on the name of the OS release:
````
salt -G "oscodename:wheezy" some_module
```
####Daily sysadmin stuff

List available package updates for all Minions
```
salt "*" pkg.list_upgrades
```
Show the installed version of a specific package on all Salt Minions:
```
salt "*" pkg.version "openssh-server"
```
Install a package on all Salt Minions. If the package is already installed, it will be updated:
```
salt "web*" pkg.install dstat
```
Check if a specific application/process is running on the Salt minions:
```
salt "*" ps.grep apache
```

####Gather/collect/pull files from Salt minions and upload them to the master:
```
salt "web*" cp.push /var/log/dpkg.log
```
Check if a file on the Salt minions contains a certain string (search file on minions):
```
salt "*" file.contains /etc/hosts.allow "yber"
```
Check if a file on the Salt minions contains a certain regex (search file on minions):
```
salt "*" file.contains_regex /etc/resolv.conf "timeout.4"
```
Push or upload or copy a file from the Salt master to the Salt minions:
```
salt-cp "*" some_script.py /target-dir/some_script.py
```

####Job management in Salt

As you might know, a command you run via Salt “(e.g. salt “*” test.ping”) is called a job. In order to list all jobs your master ever handled, simply type in:
```
salt-run jobs.list_jobs
```


Running shell commands with Salt:
```
salt "*" cmd.run "ls -lah /home/"
```
Another example for running a shell command via Salt would be installing a package via apt-get install. This is a bad example, though, since Salt contains a package handling module:
```
salt "web*" cmd.run "apt-get install --reinstall --yes dstat"
```
Hints for the Salt master configuration

As a default, the Salt master returns only the data from the minions which could be reached. But if you want to see what Salt minions did not reply, you need to add “–show-timeout” to every Salt call. However, there is a method of making this option a default: Simply add the following string to the Salt master config file:
```
show_timeout: True
```

Furthermore, if you would like to allow the Minions being able to transfer files to the master, make sure to add this config var to the master config file:
```
file_recv: True
```

Afterwards simply reload/restart the Salt master.
Please note that “file_recv” maybe a security risk for your infrastructure.
