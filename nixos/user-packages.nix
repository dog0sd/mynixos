{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development
    gnupg
    go
    gcc
    jq
    openssl
    tmux  # Terminal multiplexer

    # Steam gaming platform
    steam
    # Useful extras for Steam
    gamemode                # Optimize system performance for games launched via Steam
    mangohud                # Performance overlay and benchmarking for Vulkan/OpenGL

    
    # Applications
    ayugram-desktop
    discord
    kdePackages.kdenlive
    obsidian
    playerctl
    prismlauncher
    qbittorrent
    spotify
    feather
    code-cursor
    kdePackages.kdeconnect-kde
    
    
    # Terminal tools
    starship 
    rose-pine-hyprcursor
    cmatrix
    yazi
    htop
    btop
    cava
    fastfetch
    age
    dysk
    agenix-cli
    termusic

    # AI
    claude-code
    claude-monitor
    cursor-cli
    gemini-cli
    beads

    # Android development tools
    android-studio     # Official IDE for Android app development
    sqlite
    zoom-us
    
    # fdroidserver    # F-Droid repo tools
    

  ];

  # Why is this running?
  home.file.".local/bin/witr" = {
    source = let
      src = pkgs.fetchurl {
        url = "https://github.com/pranshuparmar/witr/releases/download/v0.1.0/witr-linux-amd64";
        sha256 = "4ac27fecb6a8561e17d4a65926b8cb036ede9d9c876c5125f1e9b92340c4e893";
      };
    in pkgs.runCommand "witr" { } ''
      cp ${src} $out
      chmod +x $out
    '';
  };
}

