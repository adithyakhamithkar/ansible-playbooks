# Azure and Ansible

## Set up credentials in group vars
```
azure_subscription_id:
azure_client_id:
azure_secret:
azure_tenant:
```
> More info to register an app

> https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications

> https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal

> Finding the `azure_subscription_id`
> https://blogs.msdn.microsoft.com/mschray/2016/03/18/getting-your-azure-subscription-guid-new-portal/

> https://medium.com/@pavithra_38952/building-infrastructure-with-microsoft-azure-and-ansible-e5245e5b33a8

## Install azure-cli
```
curl -L https://aka.ms/InstallAzureCli | bash
```

## Python dependancies for ansible
```
pip install azure==2.0.0rc5
pip install packaging
pip install msrestazure
pip install ansible[azure]
```

## Sets to set up an environment in Azure
1. Create a resource group
2. Create a virtual network
3. Create a security group
4. Create a subnet
5. Create a availability set

Creating a virtual machine with public Static IP
```
ansible-playbook -i inventory/hosts Azure/create-virtual-machine.yml -e "public_ip_allocation_method=Static"
```

Azure VM sizes
https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes
