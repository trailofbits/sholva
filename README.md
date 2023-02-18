shol'va <img src="https://user-images.githubusercontent.com/3059210/147595717-ec80740c-d4eb-4dd5-972a-d57c228c042d.png" width="48">
=======

<!-- Icon attribution: Mikla, https://commons.wikimedia.org/wiki/File:Apophis_Symbol_(Stargate).svg -->

[![Build Status](https://github.com/trailofbits/sholva/actions/workflows/ci.yml/badge.svg)](https://github.com/trailofbits/sholva/actions?query=workflow%3ACI)

*shol'va* is a Verilog and [Clash](https://clash-lang.org/) implementation of a Tiny86 trace verifier.

## Usage

### Dependencies

Built using [nix](https://nixos.wiki/wiki/Nix_package_manager).
Follow the upstream [nix installation instructions](https://nixos.org/download.html).

### Building

*shol'va* currently builds as a sanity test, producing no actual outputs.
To run the build:

```bash
$ nix-shell --run "make"
```

Independently, you can run *shol'va*'s self tests:

```bash
$ make check
# or limit the checks to a subset
$ CHECKS="alu fetch execute" nix-shell --run "make check"
```

You can also run *shol'va*'s modules through Verilator's linter.

```bash
$ nix-shell --run "make lint"
```

## Distribution and Licensing

This research was developed with funding from the Defense Advanced Research Projects Agency (DARPA) under Agreement No. HR001120C0084.

The views, opinions, and/or findings expressed are those of the author(s) and
should not be interpreted as representing the official views or policies of the
Department of Defense or the U.S. Government.

DISTRIBUTION STATEMENT A: Approved for public release, distribution unlimited.

*shol'va* is licensed under the GNU AGPLv3 License. A copy of the terms can
be found in the [LICENSE](./LICENSE) file.
