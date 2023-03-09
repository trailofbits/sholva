{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

let
  # local derivations
  mttn = pkgs.callPackage ./mttn/derivation.nix { };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix { };
in with pkgs;
stdenv.mkDerivation {
  name = "sholva";
  src = ./.;

  propagatedBuildInputs = [ mttn tiny86 ];

  doCheck = false;

  installPhase = "";
}
