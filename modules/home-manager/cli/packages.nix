{
  pkgs,
  ...
}:
{

  home-manager.users.fqian = {
    home = {
      packages = with pkgs; [
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
