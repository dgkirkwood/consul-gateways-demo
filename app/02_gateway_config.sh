#!/bin/bash

echo "Creating ingress gateway and linking with frontend application..."
curl --request PUT --data @ingress.json http://34.87.221.15:80/v1/config

echo "Registering the DB Service with Consul..."
curl --request PUT --data @ext_svc.json ac855ff6bc60e49dba7bc1c2f2a618e5-1134684195.ap-southeast-2.elb.amazonaws.com:80/v1/agent/service/register

echo "Linking the service to the Terminating Gateway..."
curl --request PUT --data @svc_link.json ac855ff6bc60e49dba7bc1c2f2a618e5-1134684195.ap-southeast-2.elb.amazonaws.com:80/v1/config

curl --request PUT --data @paymentsresolver.json http://34.87.221.15:80/v1/config

curl --request PUT --data @paymentssplitter.json http://34.87.221.15:80/v1/config