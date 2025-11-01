{ config, ... }:
{
  home-manager.users.fqian = {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        log = {
          enabled = false;
        };
      };
    };
  };
}
