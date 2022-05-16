make generate
make manifests
make install

export IMG=docker.io/navadiaev/marvell-sriov-operator:latest
export NAMESPACE=sriov-network-operator

cd config/manager
kustomize edit set image controller=${IMG}
kustomize edit set namespace "${NAMESPACE}"
cd ../../

cd config/default
kustomize edit set namespace "${NAMESPACE}"
cd ../../

#build and push sriov operator
docker build -f Dockerfile -t "navadiaev/marvell-sriov-operator" .
docker push navadiaev/marvell-sriov-operator:latest

#build and push network config
docker build -f Dockerfile.sriov-network-config-daemon -t "navadiaev/marvell-sriov-config" .
docker push navadiaev/marvell-sriov-config:latest

#build and push webhook
docker build -f Dockerfile.webhook -t "navadiaev/marvell-sriov-webhook" .
docker push navadiaev/marvell-sriov-webhook:latest

#deploy to operator
make deploy-setup