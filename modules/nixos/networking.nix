{ lib, ... }:
{
  networking = {
    wireless = {
      enable = true;
      networks = {
        "VM3764440" = {
          psk = "wtw3mzywDbNw";
        };
        "iPhone 13 Pro" = {
          psk = "reps4jesus";
        };
        "ASK4 Wireless (802.1x)" = {
          auth = ''
            key_mgmt=WPA-EAP
            identity="fqian"
            password="amount-strong-got-electric"
            phase2="auth=MSCHAPV2"
          '';
        };
        "ASK4 Wireless" = {
          psk = "amount-strong-got-electric";
        };
      };
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
