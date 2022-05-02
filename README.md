shol'va <img src="https://user-images.githubusercontent.com/3059210/147595717-ec80740c-d4eb-4dd5-972a-d57c228c042d.png" width="48">
=======

<!-- Icon attribution: Mikla, https://commons.wikimedia.org/wiki/File:Apophis_Symbol_(Stargate).svg -->

[![Build Status](https://github.com/trailofbits/sholva/actions/workflows/ci.yml/badge.svg)](https://github.com/trailofbits/sholva/actions?query=workflow%3ACI)

*shol'va* is a Verilog implementation of a Tiny86 trace verifier.

## Usage

### Dependencies

*shol'va* currently depends on iVerilog, Verilator, Python 3, and Ruby (for code generation).
These must be available as `iverilog`, `verilator`, `python3`, and `ruby` respectively.

### Building

*shol'va* currently builds as a sanity test, producing no actual outputs.
To run the build:

```bash
$ make
```

If you have `sv-netlist` on your PATH, you can build a BLIF-formatted netlist:

```bash
# creates tiny86.blif
$ make netlistify
```

Independently, you can run *shol'va*'s self tests:

```bash
$ make check
# or limit the checks to a subset
$ make check CHECKS="alu fetch execute"
```

You can also run *shol'va*'s modules through Verilator's linter.

```bash
$ make lint
```

## Distribution and Licensing

The views, opinions, and/or findings expressed are those of the author(s) and
should not be interpreted as representing the official views or policies of the
Department of Defense or the U.S. Government.

*shol'va* is licensed under the GNU AGPLv3 License. A copy of the terms can
be found in the [LICENSE](./LICENSE) file.
