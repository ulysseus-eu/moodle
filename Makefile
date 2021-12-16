build:
	$(MAKE) -C moodle build
	$(MAKE) -C shibd build
	$(MAKE) -C metadata-fetcher build

rebuild:
	$(MAKE) -C moodle rebuild
	$(MAKE) -C shibd rebuild
	$(MAKE) -C metadata-fetcher rebuild

push:
	$(MAKE) -C moodle push
	$(MAKE) -C shibd push
	$(MAKE) -C metadata-fetcher push
