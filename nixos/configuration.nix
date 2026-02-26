{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./development-packages.nix
      ./gui.nix
      ./sound.nix
      ./dns.nix
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "root" "@wheel" ];
  };

  # Garbage collection to save disk space
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };


  environment.localBinInPath = true;

  # Networking
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  
  networking.firewall.allowedTCPPorts = [ 8000 ];
  networking.firewall.allowedUDPPorts = [ ];

  # Time and Locale
  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
     LC_CTYPE = "ru_RU.UTF-8";
  };

  # Services
  services.printing.enable = true;
  services.udev.packages = [ pkgs.libinput ];
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.libinput.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;

  # Users
  users.users.grisha = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkManager" "input" "wireshark" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [ tree ];
  };
  
  home-manager.backupFileExtension = "backup";

  # Hardware
  hardware.bluetooth.enable = true;
  hardware.enableAllFirmware = true;
  hardware.firmware = [ pkgs.sof-firmware ];

  # Programs
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
  programs.kdeconnect.enable = true;
  
  # Steam configuration - enables OpenGL/GLX support and necessary libraries
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Opens firewall ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Opens firewall ports for dedicated servers
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  system.stateVersion = "25.05";
}
