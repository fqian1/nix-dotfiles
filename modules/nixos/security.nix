{ ... }:
{
  security.sudo.enable = false;

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
