#!/bin/bash

echo "Creating ingress gateway and linking with frontend application..."
curl --request PUT --data @ingress.json http://<REPLACE_WITH_GKE_CONSUL_PUBLIC_ADDRESS>:80/v1/config

echo "Registering the DB Service with Consul..."
curl --request PUT --data @ext_svc.json http://<REPLACE_WITH_AWS_CONSUL_PUBLIC_ADDRESS>:80/v1/agent/service/register

echo "Linking the service to the Terminating Gateway..."
curl --request PUT --data @svc_link.json http://<REPLACE_WITH_AWS_CONSUL_PUBLIC_ADDRESS>:80/v1/config

