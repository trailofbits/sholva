{ sources ? import ../nix/sources.nix
, rustPlatform
, fetchFromGitHub
}:
let
  pkgs = import sources.nixpkgs {
    overlays = [
      (import (fetchTarball "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz"))
    ];
  };
in
with pkgs; rustPlatform.buildRustPackage rec {
  pname = "mttn";
  version = "1.0.0";

  # FIXME(jl): a subset of tests depend on files outside of the mttn source tree. disabling at build-time now.
  doCheck = false;
  src = ./.;

  propagatedBuildInputs = [ latest.rustChannels.nightly.rust ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = true;
  };
}
