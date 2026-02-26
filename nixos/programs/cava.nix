{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cava
  ];
  
  xdg.configFile."cava/config".text = ''
    [general]
    [color]
    theme = "matugen"
  '';
}

