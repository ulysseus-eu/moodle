
build:
	$(MAKE) -C moodle build
	$(MAKE) -C shibd build
	$(MAKE) -C metadata-fetcher build
