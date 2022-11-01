with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "mttn";
  src = ./.;

  nativeBuildInputs = [
    cargo
  ];
  buildInputs = [
    clippy
    gdb
    git
    nasm
    rustfmt
  ];
}
