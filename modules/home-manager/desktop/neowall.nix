{pkgs, ...}: {
  home.packages = with pkgs; [
    neowall
  ];

  xdg.configFile."neowall/config.vibe" = {
    text = ''
      default {
        shader retro_wave.glsl
        shader_speed 1.0
        shader_fps 80
        vsync false
        show_fps true
      }
    '';
  };

  xdg.configFile."neowall/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
