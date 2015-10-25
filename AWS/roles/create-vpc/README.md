###Variable format
```
##Environment variables
vpc_name : Staging-VPC
aws_region : us-west-2
resource_tags : { "Name":"Staging-VPC" }
cidr_block : 10.0.0.0/16
#Subnet-web
cidr_web : 10.0.1.0/24
az_web: us-west-2c
resource_tags_web_us_west_2c : { "Name":"Staging-us-west-2c", "Environment":"Staging", "Service" : "Web" }
```
