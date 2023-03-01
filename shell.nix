{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:

let
  # local derivations
  mttn = pkgs.callPackage ./mttn/derivation.nix { };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix { };
  # remote derivations, managed by niv
  sv_circuit = import sources.sv_circuit { };

  haskell = pkgs.haskellPackages.ghcWithPackages (p: with p; [
    haskell-language-server
    hindent
    hlint
  ]);
in
with pkgs;
mkShell {
  nativeBuildInputs = [
    mttn
    sv_circuit
    tiny86
  ];

  # development-specific dependencies
  buildInputs = [
    haskell
    gdb
    nasm
    qemu
  ];
}
