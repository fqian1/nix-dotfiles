{ inputs, ... }:
{
  # Add custom packages in ./pkgs to pkgs
  additions = final: _prev: import ../pkgs final.pkgs;

  # Overrides for existing pkgs
  modifications = final: prev: {
    dwl = prev.dwl.overrideAttrs (oldAttrs: {
      pname = "dwl";

      src = final.fetchgit {
        url = "https://codeberg.org/dwl/dwl";
        rev = "6cd26568d5b8be2252ac0def36cd194b4fb2d7c3";
        sha256 = "ihxF9Z4uT0K3omO4mbzkeICY/RyqvuD+C5JSGWIf6MI=";
      };

      buildInputs = oldAttrs.buildInputs ++ [
        prev.wlroots
      ];

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
