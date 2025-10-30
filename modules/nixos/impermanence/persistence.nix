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
      "/etc/wireguard/"
    ];

    files = [
      "/etc/machine-id"
    ];
  };
}
