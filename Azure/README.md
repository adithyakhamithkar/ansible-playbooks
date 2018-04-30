# Azure and Ansible

# Set up credentials in group vars
```
azure_subscription_id:
azure_client_id:
azure_secret:
azure_tenant:
```

Dependency
```
pip install azure==2.0.0rc5
pip install packaging
pip install msrestazure
pip install ansible[azure]
```

Uninstall
```
pip uninstall -y $(pip freeze | grep azure)
pip uninstall -y packaging
pip uninstall -y msrestazure
pip uninstall -y ansible[azure]
```
