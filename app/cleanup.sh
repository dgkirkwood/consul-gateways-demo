#!/bin/bash

kubectl config use-context $(grep arn KCONFIG.txt)

kubectl delete -f eks_app/
helm uninstall consul

kubectl config use-context $(grep gke KCONFIG.txt)

kubectl delete -f gke_app/
helm uninstall consul

rm gke_consul/consul-federation-secret.yaml
rm KCONFIG.txt
