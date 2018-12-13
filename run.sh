#!/usr/bin/env bash

set -eu
set -x

echo "Checking that all dependencies are present..."
# Better check this before start setting up machines
terraform version > /dev/null # For provisioning
ansible-playbook --version > /dev/null # For kubespray
pip3 -V > /dev/null # For dependencies
git --version > /dev/null # For module management
jq -V > /dev/null # For configuration parsing
kubectl help > /dev/null # To test that the k8s deploy actually worked

echo "Provisioning infrastructure"
# Just call terraform
terraform init
terraform apply

echo "Deploying kubernetes"
# Getting IPS from terraform state
declare -a IPS=( $(jq .modules[0].resources <  terraform.tfstate |grep '"ipv4_address"'|cut -d\"  -f4|tr '\n' ' ') )

# Let's prepare the kubespray...
git submodule update --init --recursive kubespray
pushd kubespray
pip3 install -r requirements.txt

cp -rfp inventory/sample inventory/mycluster
CONFIG_FILE=inventory/mycluster/hosts.ini python3 contrib/inventory_builder/inventory.py ${IPS[@]}

ansible-playbook -u root -i inventory/mycluster/hosts.ini --become --become-user=root cluster.yml

echo "Kubernetes deployed, retrieving configuration"
scp root@${IPS[0]}:/root/.kube/config kubeconfig

echo "Testing get-nodes"
kubectl --kubeconfig=kubeconfig get nodes

echo "^ This looks good! :)"
