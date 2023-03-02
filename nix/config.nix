{
  packageOverrides = pkgs: rec {
    # build an extremely small qemu from scratch
    # NOTE(jl): there's a tradeoff between disk space and compilation time:
    # by not using the cached `pkgs.qemu` (which has all the below, plus a bunch or archs enabled),
    # we save a lot of disk space, but at the cost of triggering our own minimal compile.
    # fortunately an only-once thing, where the resulting derivation is cached locally.
    qemu-i386 = pkgs.qemu.override {
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
    };
  };
}
