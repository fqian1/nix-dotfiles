{ pkgs, ... }:
{
  programs = {
    ripgrep.enable = true;
    ripgrep-all.enable = true;
    tealdeer.enable = true;
    gemini-cli.enable = true;
    lazygit = {
      enable = true;
      settings = {
        git.commit.signOff = true;
      };
    };
    gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
      };
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        log = {
          enabled = false;
        };
      };
    };
  };

  home.packages = with pkgs; [
    # LSP
    lua-language-server
    yaml-language-server
    rust-analyzer
    bash-language-server
    vscode-css-languageserver
    nil
    # Formatter
    alejandra
    prettier
    rustfmt
    shfmt
    stylua
    # Tools
    hyperfine
    ffmpeg
    bottom
    bat
    ripgrep
    fd
  ];
}
