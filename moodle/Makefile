#
# Name of the final docker image.
#
DOCKER_IMAGE_NAME="educ/moodle:3.9"

build: config.php Dockerfile
	docker build -t $(DOCKER_IMAGE_NAME) .
