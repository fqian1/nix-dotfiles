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

          "ASK4-Wireless-802.1x" = {
            connection = {
              id = "ASK4 Wireless (802.1x)";
              type = "wifi";
              # uuid = "";
            };
            wifi = {
              mode = "infrastructure";
              ssid = "ASK4 Wireless (802.1x)";
            };
            wifi-sec = {
              key-mgmt = "wpa-eap";
            };
            "802-1x" = {
              eap = "PEAP";
              identity = "fqian";
              password = "amount-strong-got-electric";
              phase2-auth = "mschapv2";
            };
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
              method = "auto";
            };
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
