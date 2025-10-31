{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
  pkgs,
}:
let
  neovim-custom = (import ./neovim.nix) {
    inherit
      symlinkJoin
      neovim-unwrapped
      makeWrapper
      runCommandLocal
      vimPlugins
      lib
      pkgs
      ;
  };
in
{
  neovim-custom = neovim-custom;
}
