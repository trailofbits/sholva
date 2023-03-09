{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs { } }:

let
  # local derivations
  sholva = pkgs.callPackage ./derivation.nix { };
  # remote derivations, managed by niv
  sv_circuit = import sources.sv_circuit { };

  haskell = pkgs.haskellPackages.ghcWithPackages
    (p: with p; [ haskell-language-server hindent hlint ]);
in with pkgs;
mkShell {
  nativeBuildInputs = [ sholva ];

  # development-specific dependencies
  buildInputs = [ haskell gdb nasm qemu ];
}
