# Overview

EDUC Moodle in a container.

# Running

To start the container use the following command line:

```
docker run --publish $LOCAL_PORT:80 --volume $MOODLE_DATA_DIR:/data/ moodle-3.9
```

Where `LOCAL_PORT` is the port on the host system that you plan to connect to
to access moodle and `MOODLE_DATA_DIR` is the moodle data directory on your
system.

You also need to provide several secrets to the container. Secrets are files
containing sensitive information that need to be mounted into the container
at start time. See _Secrets_ below for details.

## Mount Points

The directory containing the used shibboleth configuration must be mounted
under `/etc/shibboleth`. The configuration is parsed by `mod_shib` to find
the entity ID of the service provider.

```
--mount type=bind,source=/local/path/to/etc/shibboleth/,target=/etc/shibboleth
```

Also, a connection to the shibboleth unix socket is expected under
`/run/shibboleth/shibd.sock`:

```
--mount type=bind,source=/local/path/to/shibd.sock,target=/run/shibboleth/shibd.sock
```

## Secrets

The image expects several secrets at defined mount points. The way to go is
using _docker-compose_ or _docker swarm_. See [docker swarm page on secrets](https://docs.docker.com/engine/swarm/secrets/)
for details.

The following files are expected to be mounted before you can run the image:

`/run/secrets/learning.educalliance.eu.crt`: the SSL certificate to use in this
    container

`/run/secrets/learning.educalliance.eu.key`: the SSL private key to use in this
    container

### docker-compose

docker-compose offers support for secrets:

```
version: "3.3"

services:
    moodle:
        image: moodle-3.9
        secrets:
          - learning.educalliance.eu.crt
          - learning.educalliance.eu.key

secrets:
    learning.educalliance.eu.crt:
        file: /my/path/to/learning.educalliance.eu.crt
    learning.educalliance.eu.key
        file: /my/path/to/learning.educalliance.eu.key

```


### Command Line Testing

For testing purposes the secrets can be mounted into the image as volumes when
calling `docker run`. For instance, to mount `learning.educalliance.eu.crt` at
start-up use the following flags:

```
--volume /my/path/to/learning.educalliance.eu.crt:/run/secrets/learning.educalliance.eu.crt
```

# Build Moodle Container

The build process of the docker image is reflected by the contents of
`Makefile`. The following sections describe the steps on the way to a
working image and will also name the makefile target.

## In a Nutshell

Copy `config.php-sample` to `config.php`, edit at will and run

```
make build
```

## Fetch Moodle Sources

See [moodle page on git](https://docs.moodle.org/39/en/Git_for_Administrators)
for download instructions.

Do

```
git clone git://git.moodle.org/moodle.git moodle
git -C moodle branch --track MOODLE_39_STABLE origin/MOODLE_39_STABLE
git -C moodle checkout MOODLE_39_STABLE

```

or

```
make update-moodle
```

to get the latest 3.9 version in the directory `moodle`.

Note: in the Makefile this step is split into to targets `moodle` and
`update-moodle`. While `moodle` will simply create the `moodle` directory
the latter step is used to fetch the latest version of the moodle branch.

## Configuration

The container will not call the moodle install script and will instead use its
own `config.php`. A sample configuration file is available in the repository
under `config.php-sample`.

## Build Container

Run

```
docker build -t moodle-3.9 .
```

or

```
make build
```

to create a docker image using the latest moodle version.
