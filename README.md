shol'va
=======

[![Build Status](https://github.com/trailofbits/sholva/actions/workflows/ci.yml/badge.svg)](https://github.com/trailofbits/sholva/actions?query=workflow%3ACI)

<!-- https://www.deviantart.com/mrs-creative/art/Shol-va-206863536 -->

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

Independently, you can run *shol'va*'s self tests:

```bash
$ make check
```

You can also run *shol'va*'s modules through Verilator's linter.

```bash
$ make lint
```
