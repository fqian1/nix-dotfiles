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
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.fqian = {
      home = {
        stateVersion = "25.05";
        username = "fqian";
        homeDirectory = if isDarwin then "/Users/fqian" else "/home/fqian";
        # sessionVariables = {
        #   SOPS_AGE_KEY_FILE = something + "/.config/sops/age/keys.txt";
        # };
      };
      programs.home-manager.enable = true;
    };
  };
  home-manager.users.root = {
    programs.git = {
      enable = true;
      settings = {
        safe = {
          directory = [ "/home/fqian/.dotfiles" ];
        };
      };
    };
    home.stateVersion = "25.05";
  };
}
