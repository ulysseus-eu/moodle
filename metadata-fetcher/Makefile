#
# Name of the final docker image.
#
DOCKER_IMAGE_NAME="ulysseus/metadata-fetcher:latest"

include ../defines.mk

build: Dockerfile
	docker build -t $(DOCKER_IMAGE_NAME) .

rebuild: Dockerfile
        docker build --no-cache -t $(DOCKER_IMAGE_NAME) .

push: build
	docker image tag ${DOCKER_IMAGE_NAME} ${DOCKER_IMAGE_URL_BASE}/${DOCKER_IMAGE_NAME}
	docker image push ${DOCKER_IMAGE_URL_BASE}/${DOCKER_IMAGE_NAME}
