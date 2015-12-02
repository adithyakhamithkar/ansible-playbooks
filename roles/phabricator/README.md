##What is phabricator?
Phabricator is a suite of open source tools for peer code review, task management, and project communication.

[Wiki](https://secure.phabricator.com/book/phabricator/)

###Note:
+ Run the storage upgrade manually
```
{{phabricator_directory}}/phabricator/phabricator/bin# ./storage upgrade
```

+ Fix base-uri or else the site looks broken in https
```
{{phabricator_directory}}/phabricator/phabricator/bin# ./config set phabricator.base-uri 'https://192.168.44.192/'
```
