{pkgs, ...}: let
  myScriptsDir = builtins.path {
    path = ./scripts;
    name = "custom-scripts-source";
  };

  customBinaries =
    pkgs.runCommand "my-script-package" {
      shell = "${pkgs.bash}/bin/bash";
    } ''
      mkdir -p $out/bin
      cp ${myScriptsDir}/max-refresh.sh $out/bin/max-refresh
      chmod +x $out/bin/max-refresh
    '';
in {
  environment.systemPackages = [
    customBinaries
  ];
}
