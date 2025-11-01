{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wget
    curl
    coreutils
    unzip
    p7zip
    openssl
    dnsutils
    nmap
    util-linux
    whois
    moreutils
    git
    age
    sops
    ssh-to-age
    tcpdump
    nvd
    tree
  ];

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
