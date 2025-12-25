{pkgs, ...}: {
  boot.kernelParams = ["snd_hda_intel.power_save=0"];
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
    qpwgraph
  ];
}
