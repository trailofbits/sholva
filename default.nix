let
  # change to nixos/nixpkgs after the following is merged
  # https://github.com/NixOS/nixpkgs/pull/178868
  pkgs = import (builtins.fetchTarball {
    name = "nixpkgs-unstable-arcz-fix-clash";
    url = "https://github.com/arcz/nixpkgs/archive/cad3ae120f5c9e4fd9c6cc2236f82c64b6f8fda8.tar.gz";
    sha256 = "sha256:0wmjqx0yjp96fcdz9fjjfllb93kaxb9hzi9ikrzaapn2zdwrbl7a";
  }) {};

  clash = pkgs.haskellPackages.ghcWithPackages (p: with p; [
    clash-lib clash-ghc clash-prelude hindent hlint
  ]);

in with pkgs; stdenv.mkDerivation {
  name = "sholva-dev";

  nativeBuildInputs = [ clash verilog verilator ruby ];

  src = ./.;
}
