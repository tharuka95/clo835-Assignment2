#!/bin/bash
set -ex
curl -sLo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/
curl -LO https://dl.k8s.io/release/v1.29.13/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/
kind create cluster --config kind.yaml
