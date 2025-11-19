{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      KbdInteractiveAuthentication = false;
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
  users.users.fqian = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDHoM9HmP7r8S7PppvUhsxZ+S0eVhYVrfK4Ap3JLkT1+ fqian@nixos-laptop"
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
