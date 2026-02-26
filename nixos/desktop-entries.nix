{ pkgs, ... }:

{
  xdg.desktopEntries = {
    cursor = {
      name = "Cursor";
      genericName = "Code Editor";
      exec = "cursor %U";
      icon = ./icons/cursor.svg;
      terminal = false;
      categories = [ "Development" "TextEditor" ];
      mimeType = [ "text/plain" "text/x-chdr" "text/x-csrc" "text/x-c++hdr" "text/x-c++src" "text/x-java" "text/x-dsrc" "text/x-pascal" "text/x-perl" "text/x-python" "application/x-shellscript" "text/x-sql" "text/x-vb" "text/xml" "text/x-makefile" "text/x-meson" "text/x-cmake" ];
    };
    "com.ayugram.desktop" = {
      name = "Telegram";
      genericName = "Messenger";
      exec = "AyuGram %U";
      icon = ./icons/tg-black.svg;
      terminal = false;
      categories = [ "Network" "InstantMessaging" "Chat" ];
      mimeType = [ "x-scheme-handler/tg" ];
    };
    vim = {
      name = "Vim";
      exec = "vim";
      noDisplay = true;
    };
    nvim = {
      name = "Neovim";
      exec = "nvim";
      noDisplay = true;
    };
    gvim = {
      name = "GVim";
      exec = "gvim";
      noDisplay = true;
    };
  };
}

