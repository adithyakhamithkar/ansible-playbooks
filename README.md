#Project Ansible [![Build Status](https://travis-ci.org/adithyakhamithkar/ansible.svg?branch=master)](https://travis-ci.org/adithyakhamithkar/ansible)
This is my pet project writing ansible playbooks. If you like my work please share your feedback and send me a Tip from [Instamojo](https://www.instamojo.com/@adithyakhamithkar)

##Index
+ AWS
    - [create-iam-admin-group](https://github.com/adithyakhamithkar/ansible/blob/master/AWS/roles/create-iam-admin-group)
    - [create-iam-group](https://github.com/adithyakhamithkar/ansible/blob/master/AWS/roles/create-iam-group)
    - [create-iam-policy](https://github.com/adithyakhamithkar/ansible/blob/master/AWS/roles/create-iam-policy)
    - [create-iam-read-only-group](https://github.com/adithyakhamithkar/ansible/blob/master/AWS/roles/create-iam-read-only-group)
    - create-iam-role
    - [create-iam-user](https://github.com/adithyakhamithkar/ansible/blob/master/AWS/roles/create-iam-user)
    - create-sg-db
    - create-sg-web
    - create-vpc
+ MySql
    - mysql-create-db
    - mysql-create-user
    - mysql-dump
    - mysql-import
    - transfer-db
+ Hacking
    - [john-the-ripper](https://github.com/adithyakhamithkar/ansible/blob/master/Hacking/roles/john-the-ripper)
+ List of Roles
    - [agar](https://github.com/adithyakhamithkar/ansible/blob/master/roles/agar)
    - [ansible](https://github.com/adithyakhamithkar/ansible/blob/master/roles/ansible)
    - bitcoin (WIP)
    - bittorrentsync
    - cachethq (Not working)
    - [cassandra](https://github.com/adithyakhamithkar/ansible/blob/master/roles/cassandra)
    - common
    - datadog-agent
    - deployment-nginx
    - docker
    + elasticsearch
        - elasticsearch-data
        - elasticsearch-master
    - glassfish
    - hostname
    - jdk
    - jenkins
        - jenkins-configure
    - [kafka](https://github.com/adithyakhamithkar/ansible/blob/master/roles/kafka)
        - [kafka-manager](https://github.com/adithyakhamithkar/ansible/tree/master/roles/kafka-manager)
    - kibana
    - ldap-server
    - lets-encrypt
    - logstash
    - logstash-forwarder
    - [mesos](https://github.com/adithyakhamithkar/ansible/blob/master/roles/mesos)
        - mesos-master
        - mesos-slave
    - mongodb
    - motd
    - mysql
    - newrelic
        - new-relic-java-agent (WIP)
        - new-relic-php-agent
        - new-relic-server-agent
    - nginx (Configured to support http 2.0)
        - nginx-jenkins
        - nginx-load-balancer
        - nginx-sensu-master
    - [ntp](https://github.com/adithyakhamithkar/ansible/tree/master/roles/ntp)
    - odoo
    + [ossec](https://github.com/adithyakhamithkar/ansible/blob/master/roles/ossec-server)
        - ossec-server
        - ossec-agent  
    - [phabricator](https://github.com/adithyakhamithkar/ansible/blob/master/roles/phabricator)
    - php
    - php7
    - [postfix](https://github.com/adithyakhamithkar/ansible/tree/master/roles/postfix)
    - psad
    - rabbit-mq
    - redis
    - roles-template
    - rootkit-scanners
        - chkrootkit
        - rkhunter
    - [s3fs](https://github.com/adithyakhamithkar/ansible/blob/master/roles/s3fs)
    - [saltstack](https://github.com/adithyakhamithkar/ansible/tree/master/roles/salt-master)
        - salt-master
        - salt-minion
    - scala
    - sensu
        - sensu-client
        - sensu-client-checks
        - sensu-master
    - solr
    - ssh-banner
    - ssh-keys
    - teamcity
    - tiger
    - tomcat
    - varnish
    - youtrack
    - [zookeeper](https://github.com/adithyakhamithkar/ansible/blob/master/roles/zookeeper)
