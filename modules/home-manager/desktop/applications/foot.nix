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
        font = "FiraCode Nerd Font:size=10";
        underline-thickness = "2px";
        underline-offset = "3px";
      };

      scrollback = {
        lines = 10000;
      };

      colors = {
        alpha = 1.0;

        background = "0A0A12";
        foreground = "FFF8F2";

        regular0 = "0A0A12";
        regular1 = "14141E";
        regular2 = "1C1C28";
        regular3 = "2A2A38";
        regular4 = "3A3A4A";
        regular5 = "E4DED2";
        regular6 = "F2EADF";
        regular7 = "FFF8F2";

        bright0 = "C25B5B";
        bright1 = "E08A66";
        bright2 = "E6C27A";
        bright3 = "8BAA82";
        bright4 = "95B3B0";
        bright5 = "6270A8";
        bright6 = "9A7398";
        bright7 = "B86C6A";
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
