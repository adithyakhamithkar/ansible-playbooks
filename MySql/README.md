Objective: To transfer one database from one server to another.
By running the shell script mysql-db-transfer.sh we can take the dump of the database, transfer and import the dump on another server.
The shell script in turn will execute ansible playbooks defined below.
Taking this further we can execute the shell script from jenkins and pass the parameters to make it more user friendly and extend.
```  
.
├── README.md                                       - You are here
├── install-mysql.yml                               - This is a playbook to install mysql
├── inventory                                       - Inventory root directory
│   ├── group_vars                                  - Group variables directory
│   │   └── all                                     - This file contains all the variables used
│   ├── hosts                                       - This file contains all the hosts details
│   └── keys
│       └── ansible.pem                             - This is the key used to SSH to the hosts
├── mysql-create-db.yml                             - This is a playbook to create a database
├── mysql-db-transfer.sh                            - This is a shell script to take the database dump, move it and import it
├── mysql-dump.yml                                  - This is a playbook to take a mysql dump
├── mysql-import.yml                                - This is a playbook to import the database dump
├── mysql-transfer-db.yml                           - This is a playbook to move the database dump from one server to another
├── roles                                           - This directory contains the different roles
│   ├── mysql                                       - This role will install mysql
│   │   ├── README.md
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── tasks                                   - This directory contains tasks
│   │   │   ├── install-automysqlbackup.yml
│   │   │   ├── install-mysql.yml
│   │   │   └── main.yml
│   │   └── templates                              - This directory contains the configuration files
│   │       ├── automysqlbackup.j2
│   │       └── my.j2
│   ├── mysql-create-db                            - This role will create a database name
│   │   ├── README.md
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   ├── mysql-dump                                - This role will create a database dump
│   │   ├── README.md
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   ├── mysql-import                              - This role will import a database dump
│   │   ├── README.md
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   └── transfer-db                               - This roles will move the database dump from one server to another
│       ├── README.md
│       ├── handlers
│       │   └── main.yml
│       ├── tasks
│       │   └── main.yml
│       └── templates
├── scripts
└── set-mysqlpassword.yml                         - This playbook will set the mysql root password
```
