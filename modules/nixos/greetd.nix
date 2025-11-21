{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.mangowc}/bin/mango";
        user = "fqian";
      };
      default_session = initial_session;
    };
  };
}
