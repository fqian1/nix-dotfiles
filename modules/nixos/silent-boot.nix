{...}: {
  boot.plymouth.enable = true;
  boot = {
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=false"
      "udev.log_level=3"
    ];
  };
}
