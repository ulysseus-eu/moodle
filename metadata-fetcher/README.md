# Overview

The _metadata-fetcher_ fetches metadata from sources configurable at the
bottom of `fetch-xml.sh` and filters out any metadata that is unwanted.
The extracted metadata is written to a directory usable from shibboleth
via the `LocalDynamic` metadata provider.

The fetcher enters an endless loop and updates metadata periodically.

It should be run as part of the docker-compose setup that is defined at the
root of this repository.

# Exports

The fetcher writes metadata to a directory which must be made available to
other services in order to use it.

`/var/lib/metadata`
: Directory receiving the metadata files formatted according to
: [LocalDynamicMetadataProvider(https://wiki.shibboleth.net/confluence/display/SP3/LocalDynamicMetadataProvider).

# Configuration

Several variables spread out in `fetch-xml.sh` can be used to configure the
behavior of `fetch-xml.sh`.
