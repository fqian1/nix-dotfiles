{ ... }:
{
  home-manager.users.fqian = {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      icons = "auto";
      git = true;
    };
  };
}
