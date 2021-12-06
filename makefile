SHELL := /bin/bash
PROJECT := $(shell gcloud config get-value project)
DOCKER_REPO_ARCHIVE := us-west1-docker.pkg.dev/$(PROJECT)
DOCKER_REPO := $(DOCKER_REPO_ARCHIVE)/decibelduck-api/decibelduck-api
DOCKER_TAG := $(shell ./tools/describe-version)
CLOUD_SERVICE := decibelduckapi

PODMAN := podman -r

.PHONY: run tidy image cloud-run

-include .env
export


# error if an environment variable was unset when this is checked
checkenv-%:
	$(if ${${*}},,$(error ${*} is undefined))


# run the http service with uvicorn
run: checkenv-PGHOST checkenv-PGUSER checkenv-PGPASSWORD checkenv-PGDATABASE
	uvicorn --reload --host 0.0.0.0 decibelduck.main:app

# clean up python source code
tidy:
	isort src/
	black src/

# build a container image with gcloud builds
cloud-build: 
	gcloud builds submit --tag $(DOCKER_REPO):$(DOCKER_TAG) .

cloud-run:
	gcloud run deploy decibelduck-be \
		--image=$(DOCKER_REPO):$(DOCKER_TAG) \
		--port=8000 \
		--region=us-west1

podman-build:
	$(PODMAN) build -t $(DOCKER_REPO):$(DOCKER_TAG) .

podman-run:
	$(PODMAN) run -d --env PORT=8000 -p 8000:8000 $(DOCKER_REPO):$(DOCKER_TAG)
	sleep 1
	$(PODMAN) ps -a --last 1 --format "{{.ID}}" | while read i; do $(PODMAN) logs $$i; done

podman-clean:
	$(PODMAN) ps -a --format "{{.ID}},{{.Image}}" \
		| grep $(DOCKER_REPO):$(DOCKER_TAG) \
		| cut -s -d, -f1 \
		| while read i; do $(PODMAN) kill $$i; sleep 0.6; $(PODMAN) rm $$i; done
	$(PODMAN) rmi $(DOCKER_REPO):$(DOCKER_TAG) || true
