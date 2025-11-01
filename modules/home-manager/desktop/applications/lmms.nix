{ pkgs, ... }:
let
  oldCmakeOverlay = final: prev: {
    oldNixpkgs = import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/7b9448665e4be84c3f97becded3676e150f94694.tar.gz";
      sha256 = "1dmp18svya7rjgsqya8xs5vqdgqimrzpk9ls1n9cg5q1gk8m9bmb";
    }) { };

    oldCmake = final.oldNixpkgs.cmake3;

    lmmsFixed = prev.lmms.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ final.oldCmake ];
      buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ final.oldCmake ];
    });
  };
in
{
  nixpkgs.overlays = [ oldCmakeOverlay ];

  home-manager.users.fqian = {
    home.packages = with pkgs; [
      lmmsFixed
    ];
  };
}
