{ pkgs, ... }:

pkgs.dwl.overrideAttrs (oldAttrs: {
  pname = "dwl";

  patches = [
    ./patches/alwayscenter.patch
    ./patches/autostart.patch
    ./patches/betterresize.patch
    ./patches/controlledfullscreen.patch
    ./patches/ipc.patch
    ./patches/systemd.patch
    ./patches/unclutter.patch
  ];

  postPatch = ''
    cp ${./config.h} config.h
  '';
})
