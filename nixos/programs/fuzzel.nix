{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main.include = "~/.config/fuzzel/colors.ini";
    };
  };
}
