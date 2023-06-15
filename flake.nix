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
  };

  outputs =
    { self, clash, nixpkgs, flake-compat, flake-utils, rust-overlay, ... }:
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
              # FIXME(jl): determine best design for `mttn`'s tracing tests.
              doCheck = false;
              meta = with lib; {
                description = "Tiny86 tracer";
                license = licenses.agpl3Only;
                platforms = [ "x86_64-linux" "i686-linux" ];
              };
            };
        };
      });
}
