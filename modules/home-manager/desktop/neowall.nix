{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neowall
  ];

  xdg.configFile."neowall/config.vibe" = {
    text = ''
      default {
        shader matrix_real.glsl
        shader_speed 1.0
      }
    '';
  };

  xdg.configFile."neowall/shaders/shader.glsl" = {
    text = '''';
  };
}
