{ pkgs, ... }:
{
  home-manager.users.fqian = {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
