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
  preCheck = ''
    make -C test elfs
  '';
  doCheck = true;

  postInstall = ''
    export MTTN=$out/bin/mttn
    export RUST_LOG=info
    make -C test traces
    mkdir -p $out/traces
    install -t $out/traces test/*.trace.txt
  '';

  meta = with lib; {
    description = "Tiny86 tracer";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
