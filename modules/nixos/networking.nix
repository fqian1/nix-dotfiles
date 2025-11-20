{lib, ...}: {
  networking = {
    wireless.enable = false;

    networkmanager = {
      enable = true;
      wifi.macAddress = "permanent";
      ensureProfiles.profiles = {
        "ASK4 Wireless (802.1x)" = {
          connection = {
            id = "ASK4 Wireless (802.1x)";
            type = "wifi";
            permissions = "";
          };
          wifi = {
            ssid = "ASK4 Wireless (802.1x)";
            mode = "infrastructure";
          };
          wifi-security = {
            key-mgmt = "wpa-eap";
            auth-alg = "open";
          };
          "802-1x" = {
            eap = "peap";
            identity = "fqian";
            password = "amount-strong-got-electric"; # dont look!!!!
            phase2-auth = "mschapv2";
            system-ca-certs = "false";
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
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
