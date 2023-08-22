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
  };

  outputs = { self, clash, nixpkgs, flake-compat, rust-overlay, sv_circuit
    , verilog_tools, ... }:
    let
      supportedSystems = [ "x86_64-linux" ];
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
            buildInputs = [
              clash.packages.${system}.clash-ghc
              clash.packages.${system}.clash-prelude
            ] ++ [
              sv_circuit.packages.${system}.sv_circuit
              verilog_tools.packages.${system}.verilog_tools
            ] ++ (with pkgs; [ nasm python3 verible verilator ]);
            propagatedBuildInputs = with pkgs; [ ruby verilog ];

            checkInputs = [ mttn ];
            preCheck = ''
              patchShebangs test/
              cp -f ${mttn}/traces/*.trace.txt test/
            '';
            doCheck = true;

            installPhase = ''
              mkdir -p $out/circuit
              cp tiny86.blif $out/circuit/

              mkdir -p $out/bin
              cp -r test/codegen $out/bin/
              cp test/run-tests $out/bin/
            '';
          };

          checkInputs = [ mttn tiny86 ];

        in rec {
          default = sholva;
          sholva = stdenv.mkDerivation rec {
            name = "sholva";
            src = ./test;

            dontBuild = true;

            doCheck = true;
            inherit checkInputs;

            installPhase = ''
              mkdir -p $out/ir0
              # install -t $out/ir0 *.circuit
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
