# log4shell exploit tracing

This directory contains code to trace a vulnerable Java app (see the [`vulnerable-app`](vulnerable-app) subdirectory)
running on a version of OpenJDK compiled to run on i386 (see the [OpenJDK-i386](OpenJDK-i386) directory).

## Tracing the exploit with mttn

In this directory, run
```shell
make log4shell.trace
```

All of the compilation of `mttn` and tracing is automagically performed in Docker. Therefore,
this `make` command can be run from the host system, even if it is not Linux.
