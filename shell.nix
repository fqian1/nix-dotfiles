{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alejandra
    nil
    stylua
    lua-language-server
    prettier
    vscode-css-languageserver
  ];
  shellHook = ''
    echo "nix dev env loaded"
  '';
}
