{ config, pkgs, ... }:

{
  home.username = "fqian";
  home.homeDirectory = "/home/fqian";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    firefox
    tree
    vim
    ripgrep
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      test = "echo test";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos";
    };
  };

  programs.git = {
    enable = true;
    userName = "fqian";
    userEmail = "francois.qian2@gmail.com";
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_familty = "FiraCode Nerd Font";
      font_size = 12.0;
      ackground_opacity = "0.8";
    };
  };

  programs.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";
      input = { kb_layout = "uk"; };
      exec-once = [ "kitty" ];
    };
  };

  programs.home-manager.enable = true;
}
