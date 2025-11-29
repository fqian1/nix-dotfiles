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
        foreground = "E4DED2";
        background = "000000";

        selection-foreground = "FFF8F2";
        selection-background = "1C1C28";

        regular0 = "14141E";
        regular1 = "C25B5B";
        regular2 = "8BAA82";
        regular3 = "E6C27A";
        regular4 = "6270A8";
        regular5 = "9A7398";
        regular6 = "95B3B0";
        regular7 = "E4DED2";

        bright0 = "2A2A38";
        bright1 = "C25B5B";
        bright2 = "8BAA82";
        bright3 = "E6C27A";
        bright4 = "6270A8";
        bright5 = "9A7398";
        bright6 = "95B3B0";
        bright7 = "F2EADF";
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
