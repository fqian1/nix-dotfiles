{ ... }:
{
  home-manager.users.fqian = {
    services.hyprpolkitagent.enable = true;
    programs.hyprlock.enable = true;
  };
}
