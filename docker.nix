{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs { } }:
let
  # local derivations
  mttn = pkgs.callPackage ./mttn/derivation.nix { };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix { };

in with pkgs;
dockerTools.buildImage {
  name = "trailofbits/sholva";
  tag = "latest";
  # NOTE(jl): it can be kind of jarring to `docker images` and see something from 1970,
  # but it means the image is reproducible! to undo:
  # created = "now";

  # NOTE(jl): this image is used as a base image for further exploits;
  # using this as a default now to mirror extant OpenJDK work.
  fromImage = dockerTools.pullImage {
    imageName = "ubuntu";
    imageDigest =
      "sha256:3626dff0d616e8ee7065a9ac8c7117e904a4178725385910eeecd7f1872fc12d";
    finalImageName = "ubuntu";
    finalImageTag = "20.04";
    sha256 = "sha256-yOLyP3zeOylc7xMf+Ulnd8taKDXdUWBN2k4VqQgmQ9U=";
    os = "linux";
    arch = "x86_64";
  };

  copyToRoot = with dockerTools;
    buildEnv {
      name = "root";
      paths = [
        # docker primitives
        bash
        # sholva
        mttn
        tiny86
        # development tools
        qemu
      ];
      pathsToLink = [ "/bin" ];
    };

  config.Cmd = [ "/bin/sh" ];
}
