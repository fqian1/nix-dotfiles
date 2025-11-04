{
  pkgs,
  ...
}:
{

  home-manager.users.fqian = {
    home = {
      packages = with pkgs; [
        # LSP
        rust-analyzer
        lua-language-server
        yaml-language-server
        jdt-language-server
        python3Packages.python-lsp-server
        python3Packages.python-lsp-ruff
        nil
        # Formatter
        rustfmt
        clippy
        alejandra
        # Tools
        cargo
        python3
        rustc
        clang-tools
        uv
        pre-commit
        gemini-cli
        neovim-custom
        swaylock
        nvim
        tlrc
        fontconfig
        fd
        jq
        fzy
        hyperfine
        yq
        direnv
        atac
        comma
        autojump
        bitwarden-desktop
        skim
        ffmpeg
        swaylock
      ];
    };
  };
}
