{ config, pkgs, lib, inputs, ...}:

{
  home.username = "grisha";
  home.homeDirectory = "/home/grisha";
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  imports = [
    ./desktop-entries.nix
    ./user-packages.nix
    ./scripts.nix
    ./programs/alacritty.nix
    ./programs/btop.nix
    ./programs/cava.nix
    ./programs/cliphist.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/matugen.nix
    ./programs/neovim.nix
    ./programs/niri.nix
    ./programs/starship.nix
    ./programs/zathura.nix
    ./programs/zsh.nix
  ];

  services = {
    mpris-proxy.enable = true;
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "never";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    ANDROID_HOME = "${pkgs.androidenv.androidPkgs.androidsdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.openjdk17}";
  };
}
