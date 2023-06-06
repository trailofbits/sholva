{ sources }:

let
  pkgs = import sources.nixpkgs { };

  sv_circuit = import sources.sv_circuit;

  mttn = pkgs.callPackage ./mttn/derivation.nix { sources = sources; };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix {
    sources = sources;
    sv_circuit = sv_circuit;
  };

  sholva-qemu =
    pkgs.callPackage ./runtime/qemu/qemu-i386.nix { sources = sources; };
in with pkgs;
stdenv.mkDerivation {
  name = "sholva";
  src = ./.;

  buildInputs = [ mttn tiny86 sholva-qemu nasm ];

  preCheck = ''
    patchShebangs ./test/
  '';
  doCheck = true;

  meta = with lib; {
    description = "Zero-knowledge proofs for i386 program execution";
    license = licenses.agpl3Only;
  };
}
