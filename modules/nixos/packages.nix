{ pkgs, ... }:
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
}
