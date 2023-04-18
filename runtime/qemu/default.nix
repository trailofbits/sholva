{ sources ? import ../../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

pkgs.callPackage ./qemu-i386.nix { sources = sources; }
