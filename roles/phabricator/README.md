##What is phabricator?
Phabricator is a suite of open source tools for peer code review, task management, and project communication.

[Wiki](https://secure.phabricator.com/book/phabricator/)

###Hosts example:
```
[phabricator]
phabricator ansible_ssh_host=192.168.44.197 hostname=phabricator

[phabricator:vars]
phabricator_directory=/usr/share/nginx/html
phabricator_user=phabricator
phabricator_password=12345
```

###Note:
+ Run the storage upgrade manually
```
{{phabricator_directory}}/phabricator/phabricator/bin# ./storage upgrade
```

+ Fix base-uri or else the site looks broken in https
```
{{phabricator_directory}}/phabricator/phabricator/bin# ./config set phabricator.base-uri 'https://192.168.44.192/'
```
