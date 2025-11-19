{ config, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = {
      "desktop" = {
        hostname = "192.168.1.100"; # Replace with Desktop IP or Hostname (see Step 3)
        user = "fqian";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
