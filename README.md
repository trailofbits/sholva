# shol'va <img src="https://user-images.githubusercontent.com/3059210/147595717-ec80740c-d4eb-4dd5-972a-d57c228c042d.png" width="48">

<!-- Icon attribution: Mikla, https://commons.wikimedia.org/wiki/File:Apophis_Symbol_(Stargate).svg -->

[![Build Status](https://github.com/trailofbits/sholva/actions/workflows/ci.yml/badge.svg)](https://github.com/trailofbits/sholva/actions?query=workflow%3ACI)

_shol'va_ is a tool for generating zero knowledge proofs of program execution, composed of

- _mttn_: an instruction-resolution program tracer
- _tiny86_: a Verilog and [Clash](https://clash-lang.org/) trace verifier circuit

## Usage

> **Note**: _shol'va_ does native tracing X86 Linux programs, and as a result is strictly limited to that architecture.

### Dependencies

`sholva` is built using [nix](https://nixos.wiki/wiki/Nix_package_manager).
It is recommended to use the [Determinate Systems installer](https://determinate.systems/posts/determinate-nix-installer):

```sh
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Building

### mttn

```sh
$ nix build .#mttn
```

This builds:

- `bin/mttn`: tracer binary
- `traces/*.trace.txt`: self-test tracing results

Enter a shell with development dependencies:

```sh
$ cd mttn
$ nix develop .#mttn
```

Manual testing:

```sh
# build all the of the test binaries
$ make -C test elfs
# run the mttn self-tests
$ cargo test
```

### tiny86

```sh
$ nix build .#mttn
```

This builds:

- `circuit/tiny86.blif`: synthesized circuit

Enter a shell with development dependencies:

```sh
$ cd tiny86
$ nix develop .#tiny86
```

Manual testing:

```bash
# test the full Tiny86 circuit test suite
$ make _test-tiny86
# test the Tiny86 circuit Clash components Haskell source
$ make _test-clash
# test the Tiny86 circuit Verilog components
$ make _test-verilog
# test the Tiny86 circuit Verilog components, isolating modules
$ SHOLVA_MODULES="alu syscall" make _test-verilog
# test the manual end-to-end test suite
$ make _test-pipeline
```

## Exploit Modeling

- [log4shell](https://www.cve.org/CVERecord?id=CVE-2021-44228)

Uses a provided jdk build cross-compiled to 80386.

## Distribution and Licensing

This research was developed with funding from the Defense Advanced Research Projects Agency (DARPA) under Agreement No. HR001120C0084.

The views, opinions, and/or findings expressed are those of the author(s) and
should not be interpreted as representing the official views or policies of the
Department of Defense or the U.S. Government.

DISTRIBUTION STATEMENT A: Approved for public release, distribution unlimited.

_shol'va_ is licensed under the GNU AGPLv3 License. A copy of the terms can
be found in the [LICENSE](./LICENSE) file.
