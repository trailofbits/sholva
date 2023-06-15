{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    clash.url = "github:clash-lang/clash-compiler";
    rust-overlay.url = "github:oxalica/rust-overlay";
    sv_circuit = {
      url = "github:trailofbits/sv_circuit";
      flake = false;
    };
    verilog_tools = {
      url = "github:trailofbits/verilog_tools";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = [ ];
    extra-trusted-public-keys = [ ];
  };

  outputs = { self, clash, nixpkgs, flake-compat, flake-utils, rust-overlay
    , sv_circuit, verilog_tools, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          # default = ... ;

          mttn = with import nixpkgs {
            inherit system;
            overlays = [ (import rust-overlay) ];
          };
            rustPlatform.buildRustPackage rec {
              name = "mttn";
              src = ./mttn;
              buildInputs = [ rust-bin.beta.latest.default ];
              cargoLock = { lockFile = ./mttn/Cargo.lock; };
              doCheck =
                false; # FIXME(jl): determine best design for `mttn`'s tracing tests.
              meta = with lib; {
                description = "Tiny86 tracer";
                license = licenses.agpl3Only;
                platforms = [ "x86_64-linux" "i686-linux" ];
              };
            };

          tiny86 = with import nixpkgs { inherit system; };
            stdenv.mkDerivation {
              name = "tiny86";
              src = ./tiny86;
              buildInputs = with clash.packages.${system};
                [ clash-ghc clash-prelude ]
                ++ [ (import sv_circuit) (import verilog_tools) ]
                ++ [ nasm ruby python3 verible verilator verilog ];

              # a small wrapper to expose the synthesized circuit through a script in the derivation output
              installPhase = ''
                set -e

                mkdir -p $out/circuit
                mv tiny86.blif $out/circuit

                mkdir -p $out/bin
                cat << EOF >> $out/bin/tiny86.sh
                #!/bin/sh
                cat $out/circuit/tiny86.blif
                EOF
                chmod +x $out/bin/tiny86.sh
              '';
              meta = with lib; {
                description = "Tiny86 transition circuit";
                license = licenses.agpl3Only;
              };
            };
        };
      });
}
