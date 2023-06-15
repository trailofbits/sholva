let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };

  sv_circuit = import sources.sv_circuit;
  verilog_tools = import sources.verilog_tools;

  mttn = pkgs.callPackage ./mttn/derivation.nix { sources = sources; };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix {
    sources = sources;
    sv_circuit = sv_circuit;
    verilog_tools = verilog_tools;
  };
in with pkgs;
dockerTools.buildImage {
  name = "trailofbits/sholva";
  tag = "latest";
  created = "now";
  copyToRoot = pkgs.buildEnv {
    name = "root";
    paths = with pkgs.dockerTools; [ mttn tiny86 qemu nasm which gdb binSh ];
    pathsToLink = [ "/bin" ];
  };

  config.Cmd = [ "/bin/sh" ];
}
