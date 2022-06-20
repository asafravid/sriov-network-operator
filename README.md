# sriov-network-operator

This is a POC branch. [enabling Octeon DPU hardware]


## Deploying the Operator
```
git clone https://github.com/naftalyava/sriov-network-operator
cd sriov-network-operator
make generate
make manifests
make install
make deploy-setup
```

## If you want to build and deploy your own images
1. Edit run.sh and point to desired docker images repos. When the script runs you must logon to the remote repo so that docker push command will succeed.
2. Edit hack/env.sh and point the desired components to desired repo.
3. Execute run.sh, the command will build and push all the required images to targer repos and will deploy the code on your cluster.
