{ pkgs, ... }:

{
  # --- Display Manager ---
  services.displayManager.defaultSession = "niri";
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
      kdePackages.qt5compat
    ];
    settings = {
      Theme = {
        Current = "where_is_my_sddm_theme";
        EnableAvatars = true;
      };
    };
  };

  # --- Graphics & Hardware ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      mesa
    ];
  };

  # --- Security & Lock ---
  security.pam.services.swaylock = {};

  # --- Shell & Environment ---
  programs.dms-shell.enable = true;

  environment.systemPackages = with pkgs; [
    # Wayland Core
    wayland
    wayland-protocols
    xwayland-satellite
    wl-clipboard
    
    # DM / Theming
    where-is-my-sddm-theme
    dms-shell
  ];

  # --- Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.d2coding
    noto-fonts
    noto-fonts-color-emoji
    font-awesome
    fira-code
    material-symbols
  ];
}
