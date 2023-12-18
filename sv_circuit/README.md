# sv_circuit

SIEVE circuit compositor.

## Dependencies

`sv_circuit` is built using [nix](https://nixos.wiki/wiki/Nix_package_manager).
It is recommended to use the [Determinate Systems installer](https://determinate.systems/posts/determinate-nix-installer):

```sh
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Building

```bash
$ nix build .#sv_circuit
```

## Development Environment

To enter a shell with all dependencies,

```bash
$ nix develop .#sv_circuit
```

Phases are defined as [Cargo hooks](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md#hooks-hooks).
Running a build phase manually,

```bash
$ cargoBuildHook
$ cargoCheckHook
```

However standard `cargo` commands apply, for compiling a release build and testing:

```bash
$ cargo build --release
$ cargo test
```

## Distribution and Licensing

This research was developed with funding from the Defense Advanced Research Projects Agency (DARPA) under Agreement No. HR001120C0084.

The views, opinions, and/or findings expressed are those of the author(s) and
should not be interpreted as representing the official views or policies of the
Department of Defense or the U.S. Government.

DISTRIBUTION STATEMENT A: Approved for public release, distribution unlimited.

_sv_circuit_ is licensed under the GNU AGPLv3 License. A copy of the terms can
be found in the [LICENSE](./LICENSE) file.
