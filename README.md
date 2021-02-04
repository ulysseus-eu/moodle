# Overview

Moodle in a container.

# Build Moodle Container

The build process of the docker image is reflected by the contents of
`Makefile`. The following sections describe the steps on the way to a
working image and will also name the makefile target.

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
