##What is Ansible?
It is a simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.
It is designed for multi-tier deployments.
It models the IT infrastructure by describing how all of your systems inter-relate, rather than just managing one system at a time.

![Ansible](https://raw.githubusercontent.com/adithyakhamithkar/ansible/master/roles/ansible/images/ansible.png)

##How does Ansible work?
As it’s written in python it requires python to be installed on the machine to run. It also needs jinja2, PyYAML.
It uses SSH to communicate with the hosts and to execute tasks.
The playbooks are written in YAML(Yet Another Markup Language) which is very human readable.

[Wiki](http://docs.ansible.com/)

[Ansible support group](https://groups.google.com/forum/#!forum/ansible-project)

###![ara documentation](http://ara.readthedocs.io/en/latest/index.html)
Start ara
```
ara-manage runserver -h 0.0.0.0 -p 81
```
