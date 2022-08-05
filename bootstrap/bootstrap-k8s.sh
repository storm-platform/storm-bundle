#!/bin/bash
#
# Copyright (C) 2021 Storm Project
#
# storm-bundle is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

#
# Kind
#
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
chmod +x ./kind

mv ./kind /usr/bin/kind

# 
# Kubectl
#
curl -LO "https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#
# Helm
#
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
