{ sources }:
let
  pkgs = import sources.nixpkgs {
    overlays = [
      (import (fetchTarball
        "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz"))
    ];
  };
in with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "mttn";
  version = "1.0.0";

  # FIXME(jl): a subset of tests depend on files outside of the mttn source tree. disabling at build-time now.
  doCheck = false;
  src = ./.;

  buildInputs = [
    (pkgs.rustChannelOf {
      date = "2023-03-01";
      channel = "nightly";
    }).rust
  ];

  cargoLock = { lockFile = ./Cargo.lock; };

  meta = with lib; {
    description = "Tiny86 tracer";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
