{ ... }:
{
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/NetworkManager"
      "/etc/ssh"
      "/etc/NetworkManager/system-connections"
      "/etc/wireguard/wg-CH-850.conf"
    ];

    files = [
      "/etc/machine-id"
    ];
  };
}
