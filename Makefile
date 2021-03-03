build:
	$(MAKE) -C moodle build
	$(MAKE) -C shibd build
	$(MAKE) -C metadata-fetcher build

push:
	$(MAKE) -C moodle push
	$(MAKE) -C shibd push
	$(MAKE) -C metadata-fetcher push
