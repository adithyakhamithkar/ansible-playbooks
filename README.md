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
      This is lined to the role common which installs the following:
      1. setting the hostname
      2. install and configure ntp
      3. update /etc/hosts
      4. install and configure postfix mail server
      5. install and configure logrotate
      6. install psad
          psad is an Intrusion Detection System
      7. install rootkits scanners
          install RKHunter and CHKRootKit
      8. install tiger
          again this is a security audit and intrusion detection system
      9. install ufw
      10. install misc softwares
          like git curl etc..
      After completing the common role it is linked to:
      1. motd
          This will update the default motd
      2. ssh-banner
          This will update the default ssh-baner
