{ sources }:
let
  pkgs = (import sources.nixpkgs { }).pkgsi686Linux;

  sholva-gcj = pkgs.gcj.overrideAttrs (oldgjc: rec {
    cc = oldgjc.cc.overrideAttrs (oldcc: rec {
      configureFlags = [ "--disable-threads" ] ++ oldcc.configureFlags;
    });
  });
in sholva-gcj
