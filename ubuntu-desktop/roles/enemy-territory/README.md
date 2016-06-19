Starting ET server
```
etded +set com_hunkmegs 512 +exec campaigncycle.cfg +set net_ip "IP" +exec server.cfg

nohup etded +set com_hunkmegs 512 +exec objectivecycle.cfg +set net_ip "IP" +exec server.cfg > /var/logs/et.log 2>&1 &
```
