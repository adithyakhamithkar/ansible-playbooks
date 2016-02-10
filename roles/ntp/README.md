###This playbook will install NTP

###Variables needed
```
timezone=Asia/Kolkata
```
###Example
To install and configure NTP
```
ansible-playbook -i inventory/hosts install-ntp -e "inventory= timezone="
```
To only install NTP
```
ansible-playbook -i inventory/hosts install-ntp -e "inventory= timezone=" --skip-tags "ntp-installation"
```
To only configure NTP
```
ansible-playbook -i inventory/hosts install-ntp -e "inventory= timezone=" --skip-tags "ntp-configuration"
```
