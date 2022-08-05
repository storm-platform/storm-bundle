#
# Copyright (C) 2021 Storm Project
#
# storm-bundle is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

.PHONY: start help reana

#
# Start the Storm bundle
#
start: reana   ## Start the Third Party (default)
	@echo "Finished"

#
# Reana configuration
#
reana:   ## Configure the Reana reproducible analysis platform.
	@echo "Configuring the Reana platform..."

	# kind settings
	kind create cluster --config reana/kind/kind-localhost-30443.yaml

	# prefetching images
	sh reana/scripts/prefetch-images.sh

	# deploying reana
	helm repo add reanahub https://reanahub.github.io/reana
	helm repo update
	helm install reana reanahub/reana --wait

	# configuring default user
	sh reana/scripts/create-admin-user.sh default reana john.doe@example.org mysecretpassword

#
# Documentation function (thanks for https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html)
#
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
