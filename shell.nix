{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {
    overlays = [
      (import (fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
    ];
  }
}:

let
  # local derivations
  mttn = pkgs.callPackage ./mttn/derivation.nix { };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix { };
  # remote derivations, managed by niv
  verilog_tools = import sources.verilog_tools { };
  sv_circuit = import sources.sv_circuit { };

  haskell = pkgs.haskellPackages.ghcWithPackages (p: with p; [
    haskell-language-server
    hindent
    hlint
  ]);

  rustVersion = "2023-01-01";
  rust = pkgs.rust-bin.nightly.${rustVersion}.default.override {
    extensions = [
      "rust-src"
      "clippy"
      "rustfmt"
    ];
  };
in
with pkgs;
mkShell {
  nativeBuildInputs = [
    mttn
    sv_circuit
    tiny86
    verilog_tools
  ];

  # development-specific dependencies
  buildInputs = with pkgs.haskellPackages; [
    haskell
    rust
    gdb
    ruby
  ];
}
