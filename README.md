# Valheim Dedicated Server
This Helm chart installs a Valheim dedicated server on your Kubernetes clusters.
## Install
### Requirements
* K8s cluster with [LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer) type service available
* [Auto-provisioning storage class](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) for persistence
### Build the Docker Image
Build the docker image and push to your cluster's registry
```
docker build -t someRegistry/valheim:latest docker/
```
### Install the Chart
```
helm upgrade --install --debug --atomic -t 2m valheim .
```
## Configure
### Server Config
* Update / Override "config" in the values file
  * serverName: Name that'll be displayed in the global server list. (String)
  * world: The world that'll be loaded / created on server startup. (String)
  * password: The password to get into the server, must be 5 chars long. (String)
  * public: Whether to add the server to the global server list (Boolean: 1 or 0)

### Persistence
Enable persistence in the values file.  **Note**: you'll need an [auto-provisioning storage class](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/), otherwise your pod will get stuck at initializing.

### Update admin/banned/permitted lists
* Update the files under lists/
* Push out the updates
```
helm upgrade --debug --atomic -t 2m valheim .
```
## Minikube
A local test server can be created with Minikube to mess around
```
eval $(minikube docker-env)
docker build -t valheim:latest .
minikube addons enable  metallb
kubectl edit cm -n metallb-system config
# under "addresses" add the output of:
echo $(minikube ip)/32
helm upgrade --install --debug --atomic -t 2m valheim .

# Tail server logs
kubectl logs -f -l app.kubernetes.io/instance=valheim
```
Once the server is up, you can connect to it via:
```
minikube ip
```
