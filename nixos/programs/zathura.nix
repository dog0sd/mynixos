{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      # Enable sqlite database for history
      database = "sqlite";
      
      # Use clipboard for selection
      selection-clipboard = "clipboard";
      
      # Enable recolor by default to use the theme
      recolor = true;
    };
    
    extraConfig = ''
      include "matugen.conf"
      
      # Override document colors to be more neutral/readable if Matugen's are too colorful
      set recolor-lightcolor "#c0c0c0"
      set recolor-darkcolor  "#121212"
      
      # Ensure default bg is also dark
      set default-bg "#121212"
    '';
  };
}

