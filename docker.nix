{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:
let
  # local derivations
  mttn = pkgs.callPackage ./mttn/derivation.nix { };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix { };
in
with pkgs; dockerTools.buildImage {
  name = "trailofbits/sholva";
  tag = "latest";
  created  = "now";
  copyToRoot = pkgs.buildEnv {
    name = "root";
    paths = [
      mttn
      tiny86
      # development tools
      qemu
    ];
    pathsToLink = [ "/bin" ];
  };

  config.Cmd = [ "/bin/bash" ];
}
