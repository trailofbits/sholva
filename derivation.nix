{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

let
  mttn = pkgs.callPackage ./mttn/derivation.nix { };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix { };
in with pkgs;
stdenv.mkDerivation {
  name = "sholva";
  src = ./.;

  buildInputs = [ mttn tiny86 qemu nasm ];

  preCheck = ''
    patchShebangs ./test/
  '';
  doCheck = true;
}
