{
  lib,
  config,
  pkgs,
  ...
}:
{
  systemd.shutdownRamfs = {
    enable = true;
    contents."/etc/systemd/system-shutdown/zfs-rollback".source =
      pkgs.writeShellScript "zfs-rollback" ''
        zfs='${lib.getExe config.boot.zfs.package}'
        zfs rollback -r rpool/root@empty
        zfs rollback -r rpool/var@empty
      '';
    storePaths = [ (lib.getExe config.boot.zfs.package) ];
  };
}
