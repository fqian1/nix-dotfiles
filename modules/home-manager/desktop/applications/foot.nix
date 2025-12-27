{
  config,
  pkgs,
  ...
}:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "FiraCode Nerd Font:size=10";
        underline-thickness = "2px";
        underline-offset = "3px";
      };

      scrollback = {
        lines = 10000;
      };

      colors = {
        alpha = 0.9;
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
