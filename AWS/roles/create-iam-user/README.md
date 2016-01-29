###This playbook will create an IAM user

###Variables needed
```
iam_user_name=
iam_password=
iam_group=
```
###Example
```
ansible-playbook -i inventory/hosts AWS/create-iam-user.yml -e "iam_user_name= iam_password= iam_group="
```
