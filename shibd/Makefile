#
# Name of the final docker image.
#
DOCKER_IMAGE_NAME="educ/shibd:3.1"

include ../defines.mk

build: Dockerfile
	docker build -t $(DOCKER_IMAGE_NAME) .

push: build
	docker image tag ${DOCKER_IMAGE_NAME} ${DOCKER_IMAGE_URL_BASE}/${DOCKER_IMAGE_NAME}
	docker image push ${DOCKER_IMAGE_URL_BASE}/${DOCKER_IMAGE_NAME}
