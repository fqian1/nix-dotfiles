{ config, pkgs, ... }:

{
  home.username = "fqian";
  home.homeDirectory = "/home/fqian";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      test = "echo test";
    };
  };
}
