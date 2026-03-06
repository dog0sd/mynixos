{ config, pkgs, ... }:

{
  # Allow unfree packages (should be in configuration.nix, but kept here for compatibility)
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    # Apps
    alacritty
    file
    firefox
    git
    ripgrep
    vim
    wget
    ollama
    htslib
    
    # Network and Pentesting utilities
    bind.dnsutils
    net-tools
    wirelesstools
    metasploit
    nmap
    wifite2
    aircrack-ng

    netdiscover
    hping
    gobuster
    nikto
    whois
    lsof
    bandwhich
    sysstat
    iotop
    ethtool
    httrack


    unzip
    zip

    # Codecs / Media
    bluez
    ffmpeg
    imv
    mpv
    gvfs
    jmtpfs
    ffmpegthumbnailer  # Video thumbnails for Thunar
    libdrm
    libva
    libva-utils
    poppler-utils  # PDF thumbnails for Thunar
    imagemagick

    # Gaming
    steam
    mangohud
    protonup-qt
    lutris
    bottles
    heroic
    
    # Desktop / GUI Utils
    brightnessctl
    libinput
    libnotify
    upower
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-utils
    
    # Theming
    adwaita-icon-theme

    man-pages
    man-db
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.zsh.enable = true;

  programs.nix-ld.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-vcs-plugin
      thunar-volman
      gvfs
    ];
  };

  services.ollama.enable = true;

}
