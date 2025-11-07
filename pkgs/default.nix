pkgs: {
  nvim = pkgs.callPackage ./nvim { };
  neowall = pkgs.callPackage ./neowall { };
  dwl = pkgs.callPackage ./dwl { };
}
