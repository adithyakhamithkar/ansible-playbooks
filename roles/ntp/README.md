###This playbook will install NTP

###Variables needed
```
timezone=Asia/Kolkata
```
###Example
To install and configure NTP
```
ansible-playbook -i inventory/hosts install-ntp.yml -e "inventory= timezone="
```
To only install NTP
```
ansible-playbook -i inventory/hosts install-ntp.yml -e "inventory= timezone=" --skip-tags "ntp-configuration"
```
To only configure NTP
```
ansible-playbook -i inventory/hosts install-ntp.yml -e "inventory= timezone=" --skip-tags "ntp-installation"
```
