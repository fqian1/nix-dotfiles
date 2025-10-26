{ config, ... }:
{
  home-manager.users.fqian = {
    programs.nh = {
      enable = true;
      clean.enable = false;
      flake = "~/.dotfiles/#nixos";
    };
  };
}
