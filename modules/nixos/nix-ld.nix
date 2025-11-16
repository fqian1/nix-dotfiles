{pkgs, ...}: {
  # This stuff is for binaries unpatched for nix, like games that depend on regular FHS
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # e.g. openssl
    ];
  };
}
