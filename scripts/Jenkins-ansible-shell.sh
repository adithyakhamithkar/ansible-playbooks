#!/bin/bash
echo "Starting Deployment..."

if [ "$HOST_NAME" == "" ]
then
        echo "Host Name can't be blank"
        exit 1
fi


cp deployment-nginx.yml deployment-nginx-$JOB_NAME-$BUILD_NUMBER.yml

echo "Deploying on $HOST_NAME"
sudo ansible-playbook -i inventory/hosts deployment-nginx-$JOB_NAME-$BUILD_NUMBER.yml -e "inventory=$HOST_NAME serial=$SERIAL" -vvvv || true
if [ -f /root/deployment-nginx-$JOB_NAME-$BUILD_NUMBER.retry ]
then
        echo "Deployment failed on $HOST_NAME"
        cat ~/install-lemp-$JOB_NAME-$BUILD_NUMBER.retry
        exit 1
fi
