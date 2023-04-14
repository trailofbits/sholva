{ sources }:
let
  pkgs = import sources.nixpkgs { };

  sholva-jdk = pkgs.pkgsi686Linux.jdk8_headless.overrideAttrs (old: rec {
    enableGnome2 = false;
    enableJavaFX = false;
    i386flags = "-msoft-float -mno-mmx -mno-avx -mno-sse -mno-sse2 -mno-mmx -mno-3dnow -fno-pic -mtune=i386";

    hardeningDisable = [ "pic" "stackprotector" "fortify" ];

    configureFlagsArray = [ ''
      --with-extra-cflags=${i386flags}
      --with-extra-cxxflags=${i386flags}
    '' ];
  });
in
pkgs.enableDebugging sholva-jdk
