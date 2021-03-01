# Introduction

A `Dockerfile` that creates a container that runs a
[Shibboleth SP](https://wiki.shibboleth.net/confluence/display/SP3/Home).

The container starts a shibboleth service provider configured with the entity ID
`https://learning.educalliance.eu/shibboleth` and exposes a unix socket for
communication

The service will not fetch metadata updates itself, as this leads to high memory
consumption with shibd. Instead it monitors a directory for metadata files which
are loaded or updated on-demand.

It should be run as part of the docker-compose setup that is defined at the
root of this repository.

# External Dependencies and Exports

The container requires the shibboleth SP configuration to be found at the
default location and a directory containing the metadata according to the
specification of the
[LocalDynamicMetadataProvider(https://wiki.shibboleth.net/confluence/display/SP3/LocalDynamicMetadataProvider).

It also expects certificate and private key of the service provider as a docker
secret.

It creates a unix socket which can be used by other services to communicate
with the SP. In this case, the socket should be written to an externally
reachable volume.

`credential-resolver.crt`
: Certificate used by the shibd for authentication with the IdP. This should be
: passed as a docker secret.

`credential-resolver.key`
: Private key used by the shibd for authentication with the IdP. This should be
: passed as a docker secret.

`/var/lib/metadata`
: Directory containing metadata files in a format that can be digested by the
: shibboleth `LocalDynamicMetadataProvider`. The `metadata-fetcher` can be used
: to fill a directory with these files.

`/etc/shibboleth`
: Shibboleth configuration, as found under `etc` in this directory. It is shared
: with the moodle container and thus is not part of the image.

`/run/shibboleth/shibd.sock`
: Unix domain socket to communicate with `shibd`. To access this from the
: outside provide a volume at `/run/shibboleth`.

# Configuration

Upon build the files that are located in the `etc` directory will be copied
to the containers `/etc/` directory. You should not store secrets in this
directory, see secrets section for details.

# Building an Image

A fresh image can be created by running `make build`.
