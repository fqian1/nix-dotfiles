{
  config,
  pkgs,
  ...
}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        # term = "foot";
        font = "FiraCode Nerd Font:size=10";
        underline-thickness = "2px";
        underline-offset = "3px";
      };

      scrollback = {
        lines = 10000;
      };

      colors = {
        alpha = 0.8;
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
