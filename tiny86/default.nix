let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs { };

  sv_circuit = import sources.sv_circuit;
  verilog_tools = import sources.verilog_tools { };
in pkgs.callPackage ./derivation.nix {
  sv_circuit = sv_circuit;
  verilog_tools = verilog_tools;
}
