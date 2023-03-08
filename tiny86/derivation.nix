{ sources ? import ../nix/sources.nix
, pkgs ? import sources.nixpkgs { }
, lib
, stdenv
, haskellPackages
}:

let
  verilog_tools = import sources.verilog_tools { };
  sv_circuit = import sources.sv_circuit { };

  clash = haskellPackages.ghcWithPackages (p: with p; [
    clash-lib
    clash-ghc
    clash-prelude
  ] ++ [ hlint
    hindent
  ]);
in
with pkgs; stdenv.mkDerivation {
  name = "tiny86";
  src = ./.;

  buildInputs = [
    python3
  ];

  propagatedBuildInputs = [
    clash
    sv_circuit
    verilator
    verilog
    verilog_tools
    ruby
  ];

  installPhase = "";
}
