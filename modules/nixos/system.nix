{
  config,
  lib,
  pkgs,
  ...
}:
{
  security = {
    sudo = {
      enable = true;
    };
    polkit = {
      enable = true;
    };
  };

  services = {
    fwupd = {
      enable = true;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    # keyMap = "uk";
    useXkbConfig = true;
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_GB.UTF-8";
      LANGUAGE = "en_US.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
}
