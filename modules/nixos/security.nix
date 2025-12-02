{ ... }:
{
  security.sudo.enable = false;

  security.pam.services.swaylock = {};

  programs.git = {
    enable = true;
    config = {
      safe = {
        directory = "*";
      };
    };
  };

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        noPass = false;
        keepEnv = true;
        persist = true;
      }
    ];
  };
}
