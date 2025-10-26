{ pkgs, ... }:
pkgs.callPackage (
  { callPackage }:
  {
    nvim = callPackage ./nvim { };
  }
) { }
