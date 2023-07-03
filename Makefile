REGISTRY_SERVER  ?= "ghcr.io"
IMAGE_REPOSITORY ?= $(REGISTRY_SERVER)/k8s-images/stolon
STOLON_VERSION   ?= $(shell echo $${STOLON_VERSION:-"0.17.0"})
PGVERSION        ?= $(shell echo $${PGVERSION:-"13.11"})
REVISION         ?= $(shell echo $${REVISION:-"0"})

STSENTINEL_IMAGE = $(IMAGE_REPOSITORY)/sentinel:$(STOLON_VERSION)-r$(REVISION)
STPROXY_IMAGE    = $(IMAGE_REPOSITORY)/proxy:$(STOLON_VERSION)-r$(REVISION)
STKEEPER_IMAGE   = $(IMAGE_REPOSITORY)/keeper:$(STOLON_VERSION)-$(PGVERSION)-r$(REVISION)
STOLONCTL_IMAGE  = $(IMAGE_REPOSITORY)/stolonctl:$(STOLON_VERSION)-r$(REVISION)

hadolint:
	@hadolint Dockerfile

shellcheck:
	@shellcheck include/*.sh

lint: hadolint shellcheck

build:
	@docker build .

sentinel: build
	@docker build . --target sentinel --tag ${STSENTINEL_IMAGE}
	@docker run --rm ${STSENTINEL_IMAGE} --version

proxy: build
	@docker build . --target proxy --tag ${STPROXY_IMAGE}
	@docker run --rm ${STPROXY_IMAGE} --version

stolonctl: build
	@docker build . --target stolonctl --tag ${STOLONCTL_IMAGE}
	@docker run --rm ${STOLONCTL_IMAGE} --version

keeper: build
	@docker build . --target keeper --tag ${STKEEPER_IMAGE}
	@docker run --rm ${STKEEPER_IMAGE} --version

all-images: sentinel proxy stolonctl keeper

publish-images:
	@docker push ${STSENTINEL_IMAGE}
	@docker push ${STPROXY_IMAGE}
	@docker push ${STOLONCTL_IMAGE}
	@docker push ${STKEEPER_IMAGE}
