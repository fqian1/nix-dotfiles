{
  config,
  pkgs,
  ...
}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "foot-direct";
        font = "FiraCode Nerd Font:size=7";
        underline-thickness = "2px";
      };

      scrollback = {
        lines = 10000;
      };

      colors = {
        alpha = 0.85;
        background = "000000";
      };

      cursor = {
        blink = "no";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
