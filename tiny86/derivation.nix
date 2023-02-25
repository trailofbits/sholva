{ lib, stdenv, haskellPackages, pkgs }:

let
  clash = haskellPackages.ghcWithPackages (p: with p; [
    clash-lib
    clash-ghc
    clash-prelude
    # FIXME(jl): dev deps
    # haskell-language-server
    # hindent
    # hlint
  ]);
in
with pkgs; stdenv.mkDerivation {
  name = "tiny86";

  propagatedBuildInputs = [
    clash
    nasm
    python3
    ruby
    verilator
    verilog
  ];
  buildInputs = [
    # FIXME(jl): dev deps
    clippy
    gdb
    git
    rustfmt
  ];

  doCheck = false;
  src = ./.;
}
