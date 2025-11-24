{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neowall
  ];

  xdg.configFile."neowall/config.vibe" = {
    text = ''
      default {
        shader starship_reentry.glsl
        shader_speed 1
        shader_fps 30
        vsync false
        show_fps false
      }
    '';
  };

  xdg.configFile."neowall/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
