{pkgs, ...}: let
  colorSchemes = {
    occult = {
      base00 = "0A0A12";
      base01 = "14141E";
      base02 = "1C1C28";
      base03 = "2A2A38";
      base04 = "3A3A4A";
      base05 = "E4DED2";
      base06 = "F2EADF";
      base07 = "FFF8F2";
      base08 = "C25B5B";
      base09 = "E08A66";
      base0A = "E6C27A";
      base0B = "8BAA82";
      base0C = "95B3B0";
      base0D = "6270A8";
      base0E = "9A7398";
      base0F = "B86C6A";
    };
  };

  writeScheme = name: config:
    pkgs.writeText
    # The filename in the Nix store will be 'colorSchemes/monokai.json', etc.
    "colorSchemes/${name}.json"
    (builtins.toJSON config);

  # Write all schemes to the Nix store
  schemeFiles = builtins.mapAttrs writeScheme colorSchemes;

  # Create a directory containing symlinks to all the generated JSON files
  schemesDir = pkgs.symlinkJoin {
    name = "my-color-schemes-dir";
    paths = builtins.attrValues schemeFiles;
  };
in {
  home.sessionVariables = {
    # Pass the path to the directory containing all the JSONs
    COLOR_SCHEMES_DIR = schemesDir;
  };
}
