{pkgs, ...}: {
  home.packages = with pkgs; [
    neowall
  ];

  xdg.configFile."neowall/config.vibe" = {
    text = ''
      default {
        shader shader.glsl
        shader_speed 1.0
      }
    '';
  };

  xdg.configFile."neowall/shaders/shader.glsl" = {
    text = ''
      #version 100
      precision highp float;

      uniform float time;
      uniform vec2 resolution;

      void main() {
          vec2 uv = gl_FragCoord.xy / resolution.xy;
          vec3 color = 0.5 + 0.5 * cos(time + uv.xyx + vec3(0,2,4));
          gl_FragColor = vec4(color, 1.0);
      }
    '';
  };
}
