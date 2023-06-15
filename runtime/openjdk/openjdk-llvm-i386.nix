{ sources }:
let
  pkgs = import sources.nixpkgs { };

  jdk-i386 = pkgs.pkgsi686Linux.jdk8_headless.overrideAttrs (old: rec {
    enableGnome2 = false;
    enableJavaFX = false;

    patches = [ old.patches ./clang-fixup.patch ];

    i386flags =
      "-msoft-float -mno-mmx -mno-avx -mno-sse -mno-sse2 -mno-mmx -mno-3dnow -fno-pic -fno-stack-protector -mtune=i386";

    configureFlags = old.configureFlags
      ++ [ "--with-target-bits=32" "--with-toolchain-type=clang" ];
    configureFlagsArray = [''
      --with-extra-cflags=-Wno-error=reserved-user-defined-literal -Wno-error=format-nonliteral -Wno-narrowing -D_GNU_SOURCE ${i386flags}
      --with-extra-cxxflags=${i386flags}
    ''];
  });

  sholva-jdk = jdk-i386.override { stdenv = pkgs.pkgsi686Linux.clangStdenv; };
in pkgs.enableDebugging sholva-jdk
