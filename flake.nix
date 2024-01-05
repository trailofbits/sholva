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
    sv_circuit = { url = "github:trailofbits/sv_circuit"; };
    verilog_tools = { url = "github:trailofbits/verilog_tools"; };
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

        in rec {
          # https://nixos.wiki/wiki/Overlays, "In a Nix flake"
          mttn = with pkgs.extend (import rust-overlay);
            (makeRustPlatform {
              cargo = rust-bin.beta.latest.default;
              rustc = rust-bin.beta.latest.default;
            }).buildRustPackage rec {
              name = "mttn";
              src = ./mttn;
              cargoLock = { lockFile = ./mttn/Cargo.lock; };

              nativeCheckInputs = [ nasm pkgsi686Linux.gcc gdb ];
              preCheck = ''
                CC=${pkgsi686Linux.gcc}/bin/gcc make -C test elfs
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
            ] ++ (with pkgs; [ nasm python3 verible verilator verilog ]);

            checkInputs = with pkgs; [ mttn ruby ];
            preCheck = ''
              patchShebangs test/
              cp -f ${mttn}/traces/*.trace.txt test/
            '';
            doCheck = true;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/circuit
              cp tiny86.blif $out/circuit/

              runHook postInstall
            '';
          };

          sholva = stdenv.mkDerivation {
            name = "sholva";
            src = ./test;

            buildInputs = [ mttn tiny86 ]
              ++ [ sv_circuit.packages.${system}.sv_circuit tiny86 ];
            preBuild = ''
              cp -f ${mttn}/traces/*.trace.txt .
              cp -f ${tiny86}/circuit/tiny86.blif .
            '';

            doCheck = true;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/proofs
              cp -f *.{circuit,*_input} $out/proofs

              runHook postInstall
            '';

            meta = with lib; {
              description = "Zero-knowledge proofs for i386 program execution";
              license = licenses.agpl3Only;
            };
          };
        });

      apps = forAllSystems (system: {
        mttn = {
          type = "app";
          program = "${self.packages.${system}.mttn}/bin/mttn";
        };
      });
    };
}
