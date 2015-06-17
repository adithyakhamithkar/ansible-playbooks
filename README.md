#Project Ansible
##Index
+ List of Ansible scripts
    - commission-new-server.yml
    - elasticsearch-enable-shard.yml
    - elasticsearch-health-check.yml
    - install-elasticsearch-data.yml
    - install-elasticsearch-master.yml
    - install-jenkins.yml
    - install-lemp.yml
    - install-mysql.yml
    - install-new-relic-agent.yml
    - install-nginx-php.yml
    - install-nginx.yml
    - install-php.yml
    - install-sensu-client.yml
    - install-sensu-master.yml
    - install-tomcat.yml
    - security-audit.yml
    - update-motd.yml
    - update-sensu-checks.yml
    - update-ssh-banner.yml
+ List of Roles
    - common
    - elasticsearch
    - elasticsearch-data
    - elasticsearch-master
    - glassfish
    - jdk
    - jenkins
    - motd
    - mysql
    - new-relic-agent
    - nginx
    - nginx-sensu-master
    - php
    - rabbit-mq
    - redis
    - roles-template
    - sensu-checks
    - sensu-client
    - sensu-master
    - ssh-banner
    - tomcat

###commission-new-server.yml
When a new server is launched this script can be used to install common tools and services on the server.
+ This is lined to the role common which installs the following:
    - setting the hostname
    - install and configure ntp
    - update /etc/hosts
    - install and configure postfix mail server
    - install and configure logrotate
    - install psad
      - psad is an Intrusion Detection System
    - install rootkits scanners
      - install RKHunter and CHKRootKit
    - install tiger
      - again this is a security audit and intrusion detection system
    - install ufw
    - install misc softwares
      - like git curl etc..
+ After completing the common role it is linked to:
    - motd
       - This will update the default motd
    - ssh-banner
       - This will update the default ssh-baner


Note: One can install new-relic-agent and sensu-client, sensu-checks as well in the script.
