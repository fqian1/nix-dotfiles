{lib, ...}: {
  networking = {
    networkmanager = {
      enable = true;
      ensureProfiles = {
        profiles = {
          home = {
            connection.id = "VM3764440";
            connection.type = "wifi";
            wifi.ssid = "VM3764440";
            wifi-security.key-mgmt = "wpa-psk";
            wifi-security.psk = "wtw3mzywDbNw";
          };

          hotspot = {
            connection.id = "iPhone 13 Pro";
            connection.type = "wifi";
            wifi.ssid = "iPhone 13 Pro";
            wifi-security.key-mgmt = "wpa-psk";
            wifi-security.psk = "reps4jesus";
          };
        };
      };
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    useDHCP = lib.mkForce true;
  };
}
