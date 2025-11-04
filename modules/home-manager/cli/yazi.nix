{ config, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      log = {
        enabled = false;
      };
    };
  };
}
