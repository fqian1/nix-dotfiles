{
  symlinkJoin,
  neovim-unwrapped,
  makeWrapper,
  runCommandLocal,
  vimPlugins,
  lib,
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
      ;
  };
in
{
  neovim-custom = neovim-custom;
}
