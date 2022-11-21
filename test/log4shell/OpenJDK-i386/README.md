# OpenJDK for i386

The [`Dockerfile`](Dockerfile) in this directory does a nightly build of OpenJDK
(pulled directly from its git repo) with i386 as its target architecture.

Note that not all dependencies are statically linked; these will be 32-bit, but might use
non-i386 x86 instructions. Specifically, X11 and ALSA are not statically linked, so any
Java applications that have a UI or audio will not necessarily be i386 compatible.

## Building the Docker container

```shell
make docker
```

This will tag the container as `trailofbits/openjdk-i386`.

The OpenJDK code is in `/jdk` and the compiled binaries are in
`/jdk/build/linux-x86-server-release/jdk/bin/`. This directory is also added to the `PATH`
of the container.

## Running the Docker container

```shell
make run
```

This will build the Docker container (if necessary) and start an instance. It will also
mount `pwd` on the host to `/workdir` in the container.
