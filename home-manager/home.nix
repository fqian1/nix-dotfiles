{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    outputs.homeManagerModules
  ];
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modification
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.fqian = {
      home = {
        stateVersion = "25.05";
        username = "fqian";
        homeDirectory = "/Users/fqian";
        # sessionVariables = {
        #   SOPS_AGE_KEY_FILE = something + "/.config/sops/age/keys.txt";
        # };
      };
      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";
      programs = {
        git = {
          enable = true;
          settings = {
            user = {
              Name = "fqian";
              Email = "francois.qian2@gmail.com";
            };
          };
        };
      };
      home.sessionVariables.EDITOR = "nvim";
    };
  };
}
