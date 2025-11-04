{ ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "Constant_Perceptual_Luminosity_dark";
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 12.0;
      boxDrawingScale = "0.001, 1, 1.5, 2";
      undercurlStyle = "thin-sparse";
      background_opacity = "0.8";
      shell_integration = "enabled";
      allow_remote_control = true;
    };
    extraConfig = ''
      modify_font underline_position 9
      modify_font underline_thickness 150%
      modify_font strikethrough_position 2px
    '';
  };
}
