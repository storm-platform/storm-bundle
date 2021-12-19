#
# Copyright (C) 2021 Storm Project
#
# storm-bundle is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

.PHONY: configure* start help logs

#
# Definitions
#

# Docker compose which the services
# is defined.
COMPOSE_FILE = docker-compose.yml

# Utility
RUN_IN_CONTAINER = docker-compose -f $(COMPOSE_FILE) exec $(CONTAINER_BASE) $(COMMAND)

#
# Start the Storm bundle
#
start:   ## Start the Storm Bundle (default)
	@echo "Building services"
	docker-compose -f docker-compose.yml up -d

#
# Base configuration commands
#

# Configure the Storm Portal
configure_portal:
	@echo "Configuring the Storm Portal..."

	@echo "Initializing the database..."
	$(RUN_IN_CONTAINER) portal-api invenio db init create

	@echo "Defining the default files location"
	$(RUN_IN_CONTAINER) portal-api invenio files location create --default default-location /opt/invenio/var/instance/data
	
	@echo "Creating the superuser"
	$(RUN_IN_CONTAINER) portal-api invenio roles create admin
	$(RUN_IN_CONTAINER) portal-api invenio access allow superuser-access role admin

	@echo "Indexing!"
	$(RUN_IN_CONTAINER) portal-api invenio index init
	$(RUN_IN_CONTAINER) portal-api invenio rdm-records fixtures

# Configure the Storm WS
configure_stormws:
	@echo "Configuring the Storm WS..."

	@echo "Initializing the database..."
	$(RUN_IN_CONTAINER) stormws-api invenio db init create

	@echo "Defining the default files location"
	$(RUN_IN_CONTAINER) stormws-api invenio files location create --default default-location /opt/invenio/var/instance/data

	@echo "Indexing!"
	$(RUN_IN_CONTAINER) stormws-api invenio index init

#
# Configurations
#
configure: configure_stormws configure_portal  ## Configure the Storm services.
	@echo "All services has been configured"


#
# Logs
#
logs:    ## Show the bundle service logs
	@echo "Getting the bundle logs"
	docker-compose logs -f --tail 100


#
# Documentation function (thanks for https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html)
#
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
