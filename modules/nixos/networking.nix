{ lib, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi.macAddress = "permanent";
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
