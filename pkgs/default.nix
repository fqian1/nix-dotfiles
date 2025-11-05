pkgs: {
  nvim = pkgs.callPackage ./nvim { };
  neowall = pkgs.callPackages ./neowall { };
}
