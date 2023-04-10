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

*shol'va* currently builds as a sanity test; producing proofs objects for each example in `test`.
To run the build:

```bash
$ nix-build
```

### Exploit Modeling

- [log4shell](https://www.cve.org/CVERecord?id=CVE-2021-44228)

Uses a provided jdk build cross-compiled to 80386.

### Testing

Dropping into a development shell and manually running the full test suite,

```bash
$ nix-shell {--pure}
# --pure restricts programs in $PATH to _only_ those used for building/testing *shol'va*.
[nix-shell]$ cd test
[nix-shell]$ make test
```

In the same sub-shell context, further subsets of the test suite for each subcomponent:

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

### Development Notes

For an interactive visualization of the dependency graph using [`nix-tree`](https://github.com/utdemir/nix-tree),

```bash
$ nix-instantiate | xargs -o nix-tree --derivation
```

Dependencies are managed using [`niv`](https://github.com/nmattia/niv). To bump dependencies,

```bash
# Update all dependencies.
$ niv update
# Update, e.g. nixpkgs, to a specific branch. Note that subsequent updates continue to pull from this branch.
$ niv update nixpkgs -b 22.11
```

## Distribution and Licensing

This research was developed with funding from the Defense Advanced Research Projects Agency (DARPA) under Agreement No. HR001120C0084.

The views, opinions, and/or findings expressed are those of the author(s) and
should not be interpreted as representing the official views or policies of the
Department of Defense or the U.S. Government.

DISTRIBUTION STATEMENT A: Approved for public release, distribution unlimited.

*shol'va* is licensed under the GNU AGPLv3 License. A copy of the terms can
be found in the [LICENSE](./LICENSE) file.
