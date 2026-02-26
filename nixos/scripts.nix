{ config, pkgs, ... }:

{
  home.file.".local/bin/fuzzel-emoji" = {
    source = ./scripts/fuzzel-emoji;
    executable = true;
  };

  home.file.".local/bin/fuzzel-notes" = {
    source = ./scripts/fuzzel-notes;
    executable = true;
  };

  home.file.".local/bin/fuzzel-powermenu" = {
    source = ./scripts/fuzzel-powermenu;
    executable = true;
  };

  home.file.".local/bin/fuzzel-ip" = {
    source = ./scripts/fuzzel-ip;
    executable = true;
  };

  home.file.".local/bin/fuzzel-audio-out" = {
    source = ./scripts/fuzzel-audio-out;
    executable = true;
  };
}

