# Overview

EDUC Moodle in a container.

The container holds the current setup of the EDUC moodle and offers an HTTPS
interface at port 443. It requires an external shibd service to run.

It should be run as part of the docker-compose setup that is defined at the
root of this repository.


# External Dependencies

The container requires an HTTP certificate to be provided by the docker secret
mechanism and access to the shibboleth configuration directory and the shibd
unix socket. It also needs a directory for external data storage.

`learning.educalliance.eu.crt`
: Certificate chain used for the apache HTTPS service. This should be passed as
: a docker secret.

`learning.educalliance.eu.key`
: Private key used for the apache HTTPS service. This should be passed as
: a docker secret.

`/etc/shibboleth`
: Link to the shibboleth SP configuration directory. This is required by
: `mod_shib` to determine the entity ID of the service provider.

`/var/run/shibboleth/shibd.sock`
: The unix socket generated by `shibd` required by `mod_shib` to communicate
: with the service provider.

`/data`
: A directory used as data root within moodle.

# Configuration

The moodle is configured by providing a `config.php` in this directory. A sample
configuration file is included as `config.php-sample`. The configuration file
is part of the image, so you need to rebuild after editing using `make build`.


# Building Moodle Image

The build process of the docker image is reflected by the contents of
`Makefile`. It can be triggered by running `make build`.

The following sections describe the steps on the way to a working image and will
also name the makefile target.


## Fetch Moodle Sources

See [moodle page on git](https://docs.moodle.org/39/en/Git_for_Administrators)
for download instructions.

Do

```
make update-moodle
```

to fetch the configured version to the directory `moodle`. Note that you need
deliberatly change the version number in the `Makefile` to prevent upgrading the
moodle (and thus the database) to the latest version by accident.

## Configuration

The container will not call the moodle install script and will instead use its
own `config.php`. A sample configuration file is available in the repository
under `config.php-sample`.
