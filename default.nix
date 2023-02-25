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
with pkgs; stdenv.mkDerivation {
  name = "sholva";

  propagatedBuildInputs = [
    mttn
    sv_circuit
    tiny86
    verilog_tools
  ];
}
