{...}: {
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        source = "nixos";
        color = {
          "1" = "red";
          "2" = "yellow";
        };
      };

      display = {
        separator = " | ";
      };

      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "packages"
        "memory"
        "break"
        "cpu"
      ];
    };
  };
}
