make generate
make manifests
make install

export IMG=docker.io/aravidmarvell/marvell-sriov-operator:latest
export NAMESPACE=sriov-network-operator

cd config/manager
../../bin/kustomize edit set image controller=${IMG}
../../bin/kustomize edit set namespace "${NAMESPACE}"
cd ../../

cd config/default
../../bin/kustomize edit set namespace "${NAMESPACE}"
cd ../../

#build and push sriov operator
docker build -f Dockerfile -t "aravidmarvell/marvell-sriov-operator" .
docker push aravidmarvell/marvell-sriov-operator:latest

#build and push network config
docker build -f Dockerfile.sriov-network-config-daemon -t "aravidmarvell/marvell-sriov-config" .
docker push aravidmarvell/marvell-sriov-config:latest

#build and push webhook
docker build -f Dockerfile.webhook -t "aravidmarvell/marvell-sriov-webhook" .
docker push aravidmarvell/marvell-sriov-webhook:latest

#deploy to operator
# for CentOS: one-time invokation raquired for "yum install skopeo --allowerasing"
make deploy-setup
