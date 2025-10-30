{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-Samsung_SSD_870_QVO_1TB_S5RRNF0T445025L";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "16G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };

    zpool = {
      rpool = {
        type = "zpool";
        options.cachefile = "none";
        rootFsOptions = {
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          relatime = "on";
          "com.sun:auto-snapshot" = "false";
          mountpoint = "none";
        };
        postCreateHook = "zfs snapshot rpool@empty";

        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options = {
              "com.sun:auto-snapshot" = "false";
              "mountpoint" = "legacy";
            };
            postCreateHook = "zfs snapshot rpool/root@empty";
          };
          "var" = {
            type = "zfs_fs";
            mountpoint = "/var";
            options = {
              "com.sun:auto-snapshot" = "false";
              "mountpoint" = "legacy";
            };
            postCreateHook = "zfs snapshot rpool/var@empty";
          };
          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              atime = "off";
              "com.sun:auto-snapshot" = "false";
              "mountpoint" = "legacy";
            };
          };
          "persistent" = {
            type = "zfs_fs";
            mountpoint = "/persistent";
            options = {
              "com.sun:auto-snapshot" = "false";
              "mountpoint" = "legacy";
            };
          };
          "home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options = {
              "com.sun:auto-snapshot" = "false";
              "mountpoint" = "legacy";
            };
          };
        };
      };
    };
  };
}
