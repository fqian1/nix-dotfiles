{ pkgs, ... }:
{
  home-manager.users.fqian = {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
