{ config, ... }:
{
  home-manager.users.fqian = {
    programs.ripgrep = {
      enable = true;
    };
  };
}
