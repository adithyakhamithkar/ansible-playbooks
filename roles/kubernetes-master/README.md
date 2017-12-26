# Master Isolation

By default, your cluster will not schedule pods on the master for security reasons. If you want to be able to schedule pods on the master, e.g. for a single-machine Kubernetes cluster for development, run:
```
kubectl taint nodes --all node-role.kubernetes.io/master-
```

# Create an app
```
kubectl create -f app_name.yml --record
```

# List the pods
```
kubectl get pods
```

# Get pod information
```
kubectl describe pod pod_name
```

# Delete a pod
```
kubectl delete pod
```

# Scale pods
```
kubectl scale --replicas=4 -f app_name.yml
```
OR
```
kubectl scale --replicas=1 rc/replication_controller_name
```

# List replication controller
```
kubectl get rc
```

# Delete replication controller
```
kubectl delete rc/replication_controller_name
```

# Replica Set vs Replication Controller
|                   Replica Set                        |               Replication Controller                |
|------------------------------------------------------|-----------------------------------------------------|
| Replica Set supports the new set-based selector.     | Replication Controller only supports equality-based |
| This gives more flexibility. for eg:                 | selector. for eg:                                   |
|          environment in (production, qa)             |             environment = production                |
|This selects all resources with key equal to          | This selects all resources with key equal to        |
|environment and value equal to production or qa       | environment and value equal to production           |
| rollout command is used for updating the replica set.| rolling-update command is used for updating         |
| Even though replica set can be used independently,   | the replication controller. This replaces the       |
| it is best used along with deployments which         | specified replication controller with a new         |
| makes them declarative.                              | replication controller by updating one pod          |
|                                                      | at a time to use the new PodTemplate.               |

# Kubernetes deployment commands
To get information on current deployments
```
kubectl get deployments
```

To get information about replica sets
```
kubectl get rs
```

To get pods and also show labels attached to those pods
```
kubectl get pods --show-lables
```

To get deployment status
```
kubectl rollout status deployment/app_name
```

To change the images
```
kubectl set image deployment/app_name current_image_name=new_image_name:tag
```

To edit the deployment object
```
kubectl edit deployment/app_name
```

Get the status of the rollout
```
kubectl rollout status deployment/app_name
```

Get the history of the rollout (the app should have a revisionHistoryLimit set)
```
kubectl rollout history deployment/app_name
```

Roll back to previous version
```
kubectl rollout undo deployment/app_name
```

Roll back to specific version (use history to get revision)
```
kubectl rollout undo deployment/app_name --to-revision=n
```

Expose a deployment
```
 kubectl expose deployment app_name --type=NodePort
```

Get list of services
```
kubectl get service
````

Describe an app
```
kubectl describe service app_name
```

Execute a command on pod (this will help you login to the pod)
```
kubectl exec pod_name -i -t -- /bin/bash
```

# Services
> Pods are very dynamic, they come and go on the kubernetes cluster
> When using a replication controller, pods are terminated and created during scaling operations
> When using deployments, when updating the images version, pods are terminated and new pods take the place of the older Pods
> That's why pods should never be accessed directory, but always through service
> A service is the logical bride between the mortal pods and other services or end-users
> When using the "kubectl expose" command, you can create a new service for a pod, so that it could be accessed externally
> Creating a service will create an endpoint for your pod(s)
> A ClusterIP: a virtual IP address only reachable from within the cluster
> A NodePort: a port that is the same on each node that is also reachable externally
> A LoadBancer: a LoadBancer created by the cloud provider that will route external traffic to every node on the NodePort
