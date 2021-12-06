#!/bin/bash
#
# This file is part of storm-docker.
# Copyright (C) 2021 INPE.
#
# storm-docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

#
# Install kind
#
wget https://raw.githubusercontent.com/reanahub/reana/maint-0.8/etc/kind-localhost-30443.yaml
kind create cluster --config kind-localhost-30443.yaml

#
# Prefetch the cluster images
#
wget https://raw.githubusercontent.com/reanahub/reana/maint-0.8/scripts/prefetch-images.sh
sh prefetch-images.sh

#
# Deploy the reana
#
helm repo add reanahub https://reanahub.github.io/reana
helm repo update
helm install reana reanahub/reana --wait

#
# Admin user (Optional)
#
wget https://raw.githubusercontent.com/reanahub/reana/maint-0.8/scripts/create-admin-user.sh
sh create-admin-user.sh default reana john.doe@example.org mysecretpassword
