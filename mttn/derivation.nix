{ lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "mttn";
  version = "1.0.0";

  # FIXME(jl): a subset of tests depend on files outside of the mttn source tree. disabling at build-time now.
  doCheck = false;
  src = ./.;

  cargoHash = "sha256-XFnJ9KlAJ+mNIxNYXw84DSSWsLxANJvzbbxSPCrENlA=";
}
