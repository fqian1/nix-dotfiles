{
  config,
  lib,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  time.timeZone = "Europe/London";

  programs.bash.enable = true;

  environment.variables.EDITOR = "nvim";

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  users.users.fqian = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]
    ++ (lib.optionals isDarwin [ "staff" ]);
    initialPassword = "password";
    shell = pkgs.bash;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nix = {
    enable = true;
    package = pkgs.nix;
    settings = {
      trusted-users = [
        "root"
        "fqian"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      auto-optimise-store = false;
    };

    gc = {
      automatic = true;
      dates = [ "weekly" ];
      options = "--delete-older-than 7d";
    };
  };
}
