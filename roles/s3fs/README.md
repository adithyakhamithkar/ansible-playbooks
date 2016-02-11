###This will help you mount an S3 bucket on ubuntu

###Variables needed
```
aws_access_key=
aws_secret_key=
```

###Example
To install and configure s3fs
```
ansible-playbook -i inventory/hosts s3fs.yml -e "inventory=web-server bucket_name="
```
To install only s3fs
```
ansible-playbook -i inventory/hosts s3fs.yml -e "inventory=web-server bucket_name=" --skip-tags "s3fs-configuration"
```
To configure s3fs
```
ansible-playbook -i inventory/hosts s3fs.yml -e "inventory=web-server bucket_name=" --skip-tags "s3fs-installation"
```
Note bucket name is mandatory
