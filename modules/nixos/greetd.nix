{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.mangowc}/bin/mangowc";
        user = "fqian";
      };
      default_session = initial_session;
    };
  };
}
