{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    clash = {
      url = "github:clash-lang/clash-compiler";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sv_circuit = { url = "github:trailofbits/sv_circuit?ref=jl/nix-flake"; };
    verilog_tools = {
      url = "github:trailofbits/verilog_tools?ref=jl/nix-flake";
    };
    wiztoolkit = {
      url = "git+ssh://git@github.mit.edu/sieve-all/wiztoolkit.git?ref=jl/nix";
    };
  };

  outputs = { self, clash, nixpkgs, flake-compat, rust-overlay, sv_circuit
    , verilog_tools, ... }:
    let
      supportedSystems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
          inherit (pkgs) stdenv lib;

          # add dissasembly support via capstone.
          sholva-qemu = pkgs.qemu.overrideAttrs (old: rec {
            configureFlags = [
              "--disable-strip"
              "--enable-capstone"
              "--enable-tools"
              "--localstatedir=/var"
              "--meson=meson"
              "--sysconfdir=/etc"
              "--target-list=i386-linux-user"
            ];
            buildInputs = old.buildInputs ++ (with pkgs; [ capstone ]);
          });

          # https://nixos.wiki/wiki/Overlays, "In a Nix flake"
          mttn = with pkgs.extend (import rust-overlay);
            rustPlatform.buildRustPackage rec {
              name = "mttn";
              src = ./mttn;
              buildInputs = [ rust-bin.beta.latest.default ];
              cargoLock = { lockFile = ./mttn/Cargo.lock; };

              nativeCheckInputs = [ nasm ];
              # NOTE: mttn tests use example binaries to verify reproducibility.
              preCheck = ''
                make -C test elfs
              '';
              doCheck = true;

              # In addition to the mttn binary,
              # Package all traced programs into derivation output.
              postInstall = ''
                MTTN=$out/bin/mttn RUST_LOG=info make -C test traces
                install -Dt $out/traces test/*.trace.txt
              '';
            };

          tiny86 = stdenv.mkDerivation {
            name = "tiny86";
            src = ./tiny86;
            buildInputs = with clash.packages.${system};
              [ clash-ghc clash-prelude ] ++ [
                sv_circuit.packages.${system}.sv_circuit
                verilog_tools.packages.${system}.verilog_tools
              ] ++ (with pkgs; [ nasm ruby python3 verible verilator verilog ]);

            preInstall = "patchShebangs codegen/";
            installPhase = ''
              set -e

              #mkdir -p $out/circuit
              #cp tiny86.blif $out/circuit/

              mkdir -p $out/bin
              cp codegen/* $out/bin/
            '';
          };

          buildInputs = [ mttn tiny86 ];

        in rec {
          default = sholva;
          sholva = stdenv.mkDerivation {
            name = "sholva";
            src = ./test;

            inherit buildInputs;
            doBuild = false;

            preCheck = ''
              cp ${mttn}/traces/*.trace.txt .
            '';
            doCheck = true;

            installPhase = ''
              mkdir -p $out/ir0
              install -t  $out/ir0 *.circuit
            '';

            meta = with lib; {
              description = "Zero-knowledge proofs for i386 program execution";
              license = licenses.agpl3Only;
            };
          };

          inherit mttn tiny86;
        });

      apps = forAllSystems (system: {
        mttn = {
          type = "app";
          program = "${self.packages.${system}.mttn}/bin/mttn";
        };
      });
    };
}
