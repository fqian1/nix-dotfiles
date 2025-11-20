{...}: {
  # networking = {
  #   wireless = {
  #     enable = true;
  #     networks = {
  #       "ASK4 Wireless (802.1x)" = {
  #         auth = ''
  #           key_mgmt=WPA-EAP
  #           identity="fqian"
  #           password="omitted"
  #           phase2="auth=MSCHAPV2"
  #         '';
  #       };
  #     };
  #   };
  # };

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

          "802-1x" = {
            eap = "peap";
            identity = "fqian";
            password = "omitted";
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
  };
}
