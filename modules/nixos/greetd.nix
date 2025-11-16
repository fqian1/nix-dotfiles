{pkgs, ...}: {
  greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.dwl}/bin/dwl";
        user = "fqian";
      };
      default_session = initial_session;
    };
  };
}
