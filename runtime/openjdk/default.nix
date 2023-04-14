{ sources ? import ../../nix/sources.nix, pkgs ? import sources.nixpkgs-unstable { } }:

pkgs.callPackage ./openjdk-llvm-i386.nix { }
