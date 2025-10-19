{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  neovim-custom = import ../../pkgs/nvim/neovim.nix {
    inherit (pkgs)
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
  imports = [
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/gtk.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zoxide.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/bash.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/hypridle.nix
  ];
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
  home.username = "fqian";
  home.homeDirectory = "/home/fqian";
  home.stateVersion = "25.05";
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [
    wget
    tree
    vim
    neovim-custom
    rust-analyzer
    lua-language-server
    rustfmt
    clang-tools
    jdt-language-server
    pyright
    nixfmt-rfc-style
    nil
    hyprland
    nerd-fonts.fira-code
    p7zip
    fzy
    fd
    ripgrep
    bat
    yazi
    hyperfine
    wofi
    obsidian
    qbittorrent
    wl-clipboard-rs
    blesh
    gemini-cli
  ];
  programs.wofi.enable = true;
  programs.hyprshot.enable = true;
  programs.hyprlock.enable = true;
  services.hyprpaper.enable = true;
  services.hyprpolkitagent.enable = true;
  programs.home-manager.enable = true;
}
