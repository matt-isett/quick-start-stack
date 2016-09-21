SHELL=/bin/bash

#Define Elasticsearch and kibana versions
ifndef ELASTICSEARCH_VERSION
ELASTICSEARCH_VERSION=5.0.0-alpha5
endif
ifndef KIBANA_VERSION
KIBANA_VERSION=$(ELASTICSEARCH_VERSION)
endif
export ELASTICSEARCH_VERSION
export KIBANA_VERSION

# Setup registry and image locations for elasticsearch and kibana
ELASTIC_REGISTRY=container-registry.elastic.co
BASEIMAGE=$(ELASTIC_REGISTRY)/elasticsearch/elasticsearch-alpine-base:latest
CONTAINERREGISTRY_ESIMAGE=$(ELASTIC_REGISTRY)/elasticsearch/elasticsearch:$(ELASTICSEARCH_VERSION)
CONTAINERREGISTRY_ESIMAGE_LATESTTAG=$(ELASTIC_REGISTRY)/elasticsearch/elasticsearch:latest
# Kibanas naming convention
REGISTRY=$(ELASTIC_REGISTRY)
REMOTE_IMAGE=$(REGISTRY)/kibana/kibana
VERSION_TAG=$(REMOTE_IMAGE):$(KIBANA_VERSION)
LATEST_TAG=$(REMOTE_IMAGE):latest
BASE_IMAGE=$(REGISTRY)/kibana/kibana-ubuntu-base:latest

# Common target to ensure BASEIMAGE is latest
pull-latest-baseimage:
	docker pull $(CONTAINERREGISTRY_ESIMAGE) && docker pull $(VERSION_TAG)

# Clean up left over containers and volumes from earlier failed runs
clean-up-from-last-runs:
	docker-compose down -v && docker-compose rm -f -v

add-data:
	ES_NODE_COUNT=1 docker-compose up --build elasticsearch load-data

run-es-single: pull-latest-baseimage
	ES_NODE_COUNT=1 docker-compose up --build elasticsearch

quick-start-stack: pull-latest-baseimage
	ES_NODE_COUNT=1 docker-compose up --build elasticsearch kibana metricbeat

kibana-es-stack: pull-latest-baseimage
	ES_NODE_COUNT=1 docker-compose up --build elasticsearch kibana
