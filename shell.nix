{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:

let
  # local derivations
  mttn = pkgs.callPackage ./mttn/derivation.nix { };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix { };
  # remote derivations, managed by niv
  verilog_tools = import sources.verilog_tools { };
  sv_circuit = import sources.sv_circuit { };
in
with pkgs;
mkShell {
  nativeBuildInputs = [
    mttn
    sv_circuit
    tiny86
    verilog_tools
  ];

  # development-specific dependencies
  buildInputs = with pkgs.haskellPackages; [
    clippy
    gdb
    rustfmt
    haskell-language-server
    hindent
    hlint
  ];
}
