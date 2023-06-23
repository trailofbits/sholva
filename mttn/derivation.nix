{ sources }:
let
  pkgs = import sources.nixpkgs {
    overlays = [
      (import (fetchTarball
        "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz"))
    ];
  };

  sholva-qemu =
    pkgs.callPackage ../runtime/qemu/qemu-i386.nix { inherit sources; };
in with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "mttn";
  version = "1.0.0";

  src = ./.;
  cargoLock = { lockFile = ./Cargo.lock; };

  buildInputs = [
    (pkgs.rustChannelOf {
      date = "2023-03-01";
      channel = "nightly";
    }).rust
  ];

  checkInputs = [ nasm ];
  # NOTE: mttn tests use example binaries to verify reproducibility.
  preCheck = ''
    make -C test elfs
  '';
  doCheck = true;

  # In addition to the mttn binary,
  # Package all traced programs into derivation output.
  postInstall = ''
    MTTN=$out/bin/mttn RUST_LOG=info make -C test traces
    install -Dt $out/traces test/*.trace.txt
  '';

  meta = with lib; {
    description = "Tiny86 tracer";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
