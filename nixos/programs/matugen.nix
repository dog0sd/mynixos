{ pkgs, ... }:

{
  home.packages = with pkgs; [
    matugen
  ];

  xdg.configFile."matugen/config.toml".text = ''
    [config]
    reload_on_change = true

    # Use soft default colors for blending if specific colors are needed in templates
    [config.custom_colors]
    red = { color = "#ba5e57", blend = true }
    green = { color = "#87c05e", blend = true }
    yellow = { color = "#e1c26b", blend = true }
    blue = { color = "#6c99bb", blend = true }
    magenta = { color = "#9f78e1", blend = true }
    cyan = { color = "#6db5b6", blend = true }
    
    [templates.alacritty]
    input_path = "~/.config/matugen/templates/alacritty.toml"
    output_path = "~/.config/alacritty/colors.toml"

    [templates.fuzzel]
    input_path = "~/.config/matugen/templates/fuzzel.ini"
    output_path = "~/.config/fuzzel/colors.ini"

    [templates.zathura]
    input_path = "~/.config/matugen/templates/zathura-colors"
    output_path = "~/.config/zathura/matugen.conf"

    [templates.yazi]
    input_path = "~/.config/matugen/templates/yazi-theme.toml"
    output_path = "~/.config/yazi/theme.toml"

    [templates.starship]
    input_path = "~/.config/matugen/templates/starship.toml"
    output_path = "~/.config/starship_matugen.toml"

    [templates.btop]
    input_path = "~/.config/matugen/templates/btop.theme"
    output_path = "~/.config/btop/themes/matugen.theme"

    [templates.cava]
    input_path = "~/.config/matugen/templates/cava.ini"
    output_path = "~/.config/cava/themes/matugen"
    post_hook = "pkill -USR1 cava"

    [templates.gtk3]
    input_path = "~/.config/matugen/templates/gtk-colors.css"
    output_path = "~/.config/gtk-3.0/gtk.css"

    [templates.gtk4]
    input_path = "~/.config/matugen/templates/gtk-colors.css"
    output_path = "~/.config/gtk-4.0/gtk.css"

    [templates.niri]
    input_path = "~/.config/matugen/templates/niri-colors.kdl"
    output_path = "~/.config/niri/colors.kdl"
  '';

  xdg.configFile."matugen/templates/gtk-colors.css".source = ./matugen/templates/gtk-colors.css;
  xdg.configFile."matugen/templates/alacritty.toml".source = ./matugen/templates/alacritty.toml;
  xdg.configFile."matugen/templates/fuzzel.ini".source = ./matugen/templates/fuzzel.ini;
  xdg.configFile."matugen/templates/zathura-colors".source = ./matugen/templates/zathura-colors;
  xdg.configFile."matugen/templates/yazi-theme.toml".source = ./matugen/templates/yazi-theme.toml;
  xdg.configFile."matugen/templates/starship.toml".source = ./matugen/templates/starship.toml;
  xdg.configFile."matugen/templates/btop.theme".source = ./matugen/templates/btop.theme;
  xdg.configFile."matugen/templates/cava.ini".source = ./matugen/templates/cava.ini;
  xdg.configFile."matugen/templates/niri-colors.kdl".source = ./matugen/templates/niri-colors.kdl;
}
