{ sources }:

let
  pkgs = import sources.nixpkgs { };

  sv_circuit = import sources.sv_circuit;
  verilog_tools = import sources.verilog_tools;

  mttn = pkgs.callPackage ./mttn/derivation.nix { sources = sources; };
  tiny86 = pkgs.callPackage ./tiny86/derivation.nix {
    sources = sources;
    sv_circuit = sv_circuit;
    verilog_tools = verilog_tools;
  };
  sholva-qemu = pkgs.callPackage ./runtime/qemu/qemu-i386.nix { sources = sources; };
  sholva-jdk = pkgs.callPackage ./runtime/openjdk/openjdk-llvm-i386.nix { sources = sources; };
in with pkgs;
stdenv.mkDerivation {
  name = "sholva";
  src = ./.;

  buildInputs = [ nasm ];
  propagatedBuildInputs = [
    which
    numactl
    gdb
    mttn
    tiny86
    sholva-qemu
    python3
    (enableDebugging pkgsi686Linux.jdk8_headless)
  ];

  preCheck = ''
    patchShebangs ./test/
  '';
  doCheck = true;
}
