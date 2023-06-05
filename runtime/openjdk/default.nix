{ sources ? import ../../nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

pkgs.callPackage ./openjdk-llvm-i386.nix { sources = sources; }
