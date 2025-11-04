{
  lib,
  config,
  pkgs,
  ...
}:
{
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/systemd"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/NetworkManager"
      "/etc/ssh"
      "/etc/NetworkManager/system-connections"
      "/etc/wireguard/"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };
  fileSystems."/persistent".neededForBoot = true;
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
