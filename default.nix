let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in
pkgs.callPackage ./derivation.nix { sources = sources; }
