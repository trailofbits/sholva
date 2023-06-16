# Sholva OpenJDK

OpenJDK build cross-compiled `i386`;
- compiled with LLVM toolchain,
- compiling away possible complex instructions (`-msoft-float`, `-mno-mmx`, &c)
- `clang-fixup.patch` represents minimal changes for successful compilation with clang 

# Development Notes

## GDB with Source

Get the `src` attribute of the derivation by modifying `default.nix`:

```nix
(pkgs.callPackage ./openjdk-llvm-i386.nix { sources = sources; }).src
```

and `nix-build` to have `./result` point to the unpacked source.

However, running under GDB produces absolute paths relative to the nix build environment.
To have GDB point to the unpacked source,

```sh
(gdb) set substitute-path ./result
```

Now, e.g. `(gdb) layout split` will correctly infer the source locations.
