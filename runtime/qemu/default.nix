let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in pkgs.callPackage ./qemu-i386.nix { sources = sources; }
