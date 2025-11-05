{ pkgs, ... }:
{
  networking = {
    firewall = {
      enable = true;
      checkReversePath = false;
      trustedInterfaces = [
        "wg0"
        "protonvpn"
      ];
      extraCommands = ''
        iptables -A OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
        #ip6tables -A OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
      '';
      extraStopCommands = ''
        iptables -D OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
        #ip6tables -D OUTPUT -d 89.222.96.30 -p udp --dport 51820 -j ACCEPT
      '';
    };
    wg-quick.interfaces.protonvpn = {
      autostart = true;
      configFile = "/etc/wireguard/wg-CH-850.conf";
    };
  };

  systemd.services.protonvpn-portforward = {
    description = "ProtonVPN NAT-PMP port forwarding";
    after = [ "wg-quick-protonvpn.service" ];
    wants = [ "wg-quick-protonvpn.service" ];
    path = [
      pkgs.libnatpmp
      pkgs.gawk
    ];
    script = ''
      while true; do
        date
        UDP_OUTPUT=$(natpmpc -a 1 0 udp 60 -g 10.2.0.1)
        UDP_EXIT=$?
        TCP_OUTPUT=$(natpmpc -a 1 0 tcp 60 -g 10.2.0.1)
        TCP_EXIT=$?

        if [ $UDP_EXIT -eq 0 ] && [ $TCP_EXIT -eq 0 ]; then
          # Extract port number from UDP output (assuming same port for TCP)
          PORT=$(echo "$UDP_OUTPUT" | grep -o 'Mapped public port [0-9]*' | gawk '{print $4}')
          if [ -n "$PORT" ]; then
            echo "$PORT" > /var/run/protonvpn-forwarded-port
            echo "Forwarded port: $PORT"
          else
            echo "ERROR: Could not extract port number"
          fi
        else
          echo "ERROR with natpmpc command"
          break
        fi
        sleep 45
      done
    '';
    serviceConfig = {
      Type = "simple";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
