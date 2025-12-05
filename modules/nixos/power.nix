{
  config,
  pkgs,
  ...
}: {
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    extraConfig = ''
      HandlePowerKey=suspend
      IdleAction=suspend
      IdleActionSec=30m
    '';
  };
  services.power-profiles-daemon.enable = false; # Disable GNOME/KDE default
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}
