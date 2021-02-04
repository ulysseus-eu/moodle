#
# Name of the final docker image.
#
DOCKER_IMAGE_NAME="moodle-3.9"

#
# URL of the moodle git repository.
#
MOODLE_REPOSITORY="git://git.moodle.org/moodle.git"

#
# Name of the moodle branch to use.
#
MOODLE_BRANCH="MOODLE_39_STABLE"


moodle:
	git clone $(MOODLE_REPOSITORY) moodle
	git -C moodle branch --track $(MOODLE_BRANCH) origin/$(MOODLE_BRANCH)

update-moodle: moodle
	git -C moodle checkout $(MOODLE_BRANCH)

build: update-moodle
	docker build -t $(DOCKER_IMAGE_NAME) .
