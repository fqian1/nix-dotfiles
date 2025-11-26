{ pkgs, ... }:
let
  myScriptsDir = builtins.path {
    path = ./scripts;
    name = "scripts";
  };

  customBinaries =
    pkgs.runCommand "my-script-package"
      {
        shell = "${pkgs.bash}/bin/bash";
      }
      ''
        mkdir -p $out/bin
        cp ${myScriptsDir}/max-refresh.sh $out/bin/max-refresh
        cp ${myScriptsDir}/auto-arrange-monitors.sh $out/bin/auto-arrange-monitors
        chmod +x $out/bin/max-refresh
        chmod +x $out/bin/auto-arrange-monitors
      '';
in
{
  home.packages = [
    customBinaries
  ];
}
