{ sources }:
let
  pkgs = import sources.nixpkgs { };

  sholva-qemu = pkgs.qemu.overrideAttrs (old: rec {
    numaSupport = false;
    seccompSupport = false;
    alsaSupport = false;
    pulseSupport = false;
    sdlSupport = false;
    jackSupport = false;
    gtkSupport = false;
    vncSupport = false;
    smartcardSupport = false;
    spiceSupport = false;
    ncursesSupport = false;
    usbredirSupport = false;
    xenSupport = false;
    cephSupport = false;
    glusterfsSupport = false;
    openGLSupport = false;
    virglSupport = false;
    libiscsiSupport = false;
    smbdSupport = false;
    tpmSupport = false;
    uringSupport = false;

    buildInputs = old.buildInputs ++ (with pkgs; [ capstone ]);
    configureFlags = old.configureFlags ++ [ "--enable-capstone" ];
  });
in sholva-qemu
