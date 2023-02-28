{ sources ? import ../nix/sources.nix
, pkgs ? import sources.nixpkgs { }
, lib
, stdenv
, haskellPackages
}:

let
  verilog_tools = import sources.verilog_tools { };

  clash = haskellPackages.ghcWithPackages (p: with p; [
    clash-lib
    clash-ghc
    clash-prelude
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
    verilog
    verilog_tools
  ];

  installPhase = ''
    mkdir -p $out/circuit
    ls
    cp tiny86.blif $out/circuit
  '';
}
