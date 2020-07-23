#!/bin/bash
# set -v

helm repo add hashicorp https://helm.releases.hashicorp.com

kubectl config view -o json | jq -r '.contexts[].name'  >> KCONFIG.txt

kubectl config use-context $(grep gke KCONFIG.txt)

cd gke_consul

./consul.sh

kubectl wait --timeout=120s --for=condition=Ready $(kubectl get pod --selector=app=consul -o name)
sleep 1s

cd ../

kubectl apply -f gke_app/


sleep 5s

kubectl config use-context $(grep arn KCONFIG.txt)

cd eks_consul

./consul.sh

kubectl wait --timeout=120s --for=condition=Ready $(kubectl get pod --selector=app=consul -o name)

cd ../

kubectl apply -f eks_app/