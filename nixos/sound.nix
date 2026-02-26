{config, pkgs, ...}:
{
  boot.extraModprobeConfig = ''
    options snd-sof-pci-intel-cnl disable_hdmi=1
    options snd-intel-dspcfg dsp_driver=1
  '';

  boot.kernelModules = [ "snd-sof-pci-intel-cnl" "snd-sof-intel-hda-common" ];
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire."92-bluetooth-a2dp" = {
      "context.properties" = {
        "bluez5.a2dp-ldac-quality" = "hq";
        "bluez5.codecs" = [ "sbc" "aac" "ldac" ];
      };
    };
  };
    

  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    qpwgraph
    wireplumber
    pipewire
  ];
}
