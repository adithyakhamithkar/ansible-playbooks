###This will help you mount an S3 bucket on ubuntu

###Example
```
ansible-playbook -i inventory/hosts s3fs.yml -e "inventory=web-server bucket_name="
```
Note bucket name is mandatory
