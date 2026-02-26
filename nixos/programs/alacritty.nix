{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    # theme = "iris"; # everforest_light iris
    settings = {
      general.import = [ "~/.config/alacritty/colors.toml" ];
      font.size = 14;
    };
  };
}

