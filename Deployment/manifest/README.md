# LOCAL DEPLOYEMENT
## Minikube (after installation)

### Set docker as default driver for minikube:
- minikube config set driver docker
- minikube -p clco addons enable metrics-server

## Build docker files for kubernetess - single cluster multiple nodes

- minikube start --nodes 2 -p clco --memory 2048 --cpus 2 --driver=docker
- minikube start --memory 2048 --cpus 2
- kubectl label nodes cc disktype=ssd
- kubectl label nodes cc-m03 disktype=hdd
- minikube -p clco dashboard

### Folder Backend:

- minikube -p clco docker-env | Invoke-Expression
- docker build -t cloudcomputing/backend .
- minikube -p clco image load cloudcomputing/backend

### Folder Frontend:

- minikube -p clco docker-env | Invoke-Expression
- docker build -t cloudcomputing/frontend .
- minikube -p clco image load cloudcomputing/frontend

## Create deployments(Helm installed + bitnami repository added to it)

- kubectl create -f ./manifest/localhost/backend-deployment.yaml --cluster=clco
- kubectl create -f ./manifest/localhost/frontend-deployment.yaml --cluster=clco

### Mongo DB/redis container

- helm install mongodb bitnami/mongodb --set image.repository=amd64/mongo --set image.tag=latest --set persistence.mountPath=/data/db --set volumePermissions.enabled=true --set persistence.enabled=true

- helm install redis bitnami/redis --set architecture=standalone --set auth.enabled=false --set persistence.storageClass=nfs-client,redis.replicas.persistence.storageClass=nfs-client --set volumePermissions.enabled=true 

### Port forwarding/Tunnel for loadbalancing

- kubectl port-forward services/backend 3000:90
- minikube -p clco tunnel
