{ pkgs, ... }:
let
  sholva-qemu = pkgs.qemu.overrideAttrs (old: rec {
    # rather than disable nearly all default configuration options, just override with
    # the minimal flags for desired i386 userspace emulation
    configureFlags = [
      "--disable-strip"
      "--enable-capstone"
      "--enable-tools"
      "--localstatedir=/var"
      "--meson=meson"
      "--sysconfdir=/etc"
      "--target-list=i386-linux-user"
    ];

    # FIMXE(jl): downside to configuration flags overriding is the build inputs
    # are pulling in extraneous packages at build-time.
    buildInputs = old.buildInputs ++ (with pkgs; [ capstone ]);
  });
in sholva-qemu
