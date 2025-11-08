{ inputs, ... }:
{
  # Add custom packages in ./pkgs to pkgs
  additions = final: _prev: import ../pkgs final.pkgs;

  # Overrides for existing pkgs
  modifications = final: prev: {
    dwl = prev.dwl.overrideAttrs (oldAttrs: {
      pname = "dwl";

      patches = [
        ./patches/dwl.patch
      ];

      postPatch = ''
        cp ${./config.h} config.h
      '';
    });
  };

  # Add the option to use unstable via pkgs.unstable.<package>
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
