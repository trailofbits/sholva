{ lib, stdenv, haskellPackages, pkgs }:

let
  clash = haskellPackages.ghcWithPackages (p: with p; [
    clash-lib
    clash-ghc
    clash-prelude
  ]);
in
with pkgs; stdenv.mkDerivation {
  name = "tiny86";

  propagatedBuildInputs = [
    clash
    python3
    verilator
    verilog
  ];

  doCheck = false;
  src = ./.;
}
