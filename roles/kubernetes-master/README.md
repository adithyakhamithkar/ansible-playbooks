# Master Isolation

By default, your cluster will not schedule pods on the master for security reasons. If you want to be able to schedule pods on the master, e.g. for a single-machine Kubernetes cluster for development, run:
```
kubectl taint nodes --all node-role.kubernetes.io/master-
```
