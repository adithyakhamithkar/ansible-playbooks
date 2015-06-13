#!/bin/bash
echo "Starting..."

if [ "$HOST_NAME" == "" ]
then
        echo "Host Name can't be blank"
        exit 1
fi


cp install-lemp.yml install-lemp-$JOB_NAME-$BUILD_NUMBER.yml

echo "Installing Nginx on $HOST_NAME"
ansible-playbook -i hosts-template install-lemp-$JOB_NAME-$BUILD_NUMBER.yml --extra-vars "inventory=$HOST_NAME" -v || true
if [ -f /root/install-lemp-$JOB_NAME-$BUILD_NUMBER.retry ]
then
        echo "Installation failed on $Inventory"
        cat /root/install-lemp-$JOB_NAME-$BUILD_NUMBERretry
        exit 1
fi
