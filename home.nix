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

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [ "$mod, F, exec, firefox"
               "$mod, RETURN, exec, $terminal" ];
      monitor = ",preferred,auto,auto";
      input = { kb_layout = "gb"; };
      exec-once = [ "kitty" ];
    };
  };

  programs.home-manager.enable = true;
}
