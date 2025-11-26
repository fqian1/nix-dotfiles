{ ... }:
{
  security.sudo.enable = false;

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
