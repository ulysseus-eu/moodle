# Overview

This is a `docker-compose`-based setup of the EDUC moodle platform. It supports
SAML-based single sign-on via the shibboleth service provider and uses an
external database and an external moodle data storage for to store its data.

The setup consists of the following components:

- [Script to Periodically Fetch Metadata](metadata-fetcher)
- [Shibboleth Service Provider](shibd)
- [Moodle Hosted by Apache](moodle)

# Usage

The setup is configured over environment variables. These variables should be
defined using the `.env` file mechanism of `docker-compose`. A sample env file
can be found under `.env-sample`.

For the setup to run, a set of container images must be available on the target
machine. The required images can be created using the `Dockerfile`s in the
contained sub-directories. To build all at once you can run `make build` from
the top-level directory.

Once all images are generated, you can use `docker-compose up` to start the
setup.

# Configuration

Configuration happens over the `.env` file mechanism described under _Usage_.
For changing the container's behavior refer to the container sub-directories.
