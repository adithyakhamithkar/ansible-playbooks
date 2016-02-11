###This playbook will install Postfix

###Variables needed
```
#Define ssl certificate file path
ssl_crt_file=
#Define ssl key file path
ssl_key_file= 
```
###Example
To install and configure Postfix
```
ansible-playbook -i inventory/hosts install-postfix.yml -e "inventory="
```
To only install Postfix
```
ansible-playbook -i inventory/hosts install-postfix.yml -e "inventory=" --skip-tags "postfix-configuration"
```
To only configure Postfix
```
ansible-playbook -i inventory/hosts install-postfix.yml -e "inventory=" --skip-tags "postfix-installation"
```
