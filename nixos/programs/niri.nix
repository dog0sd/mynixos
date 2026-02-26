{ config, pkgs, ... }:

{
  
  xdg.configFile."niri/config.kdl".text = ''

    input {
      keyboard {
        xkb {
          layout "us,ru"
          options "grp:alt_shift_toggle,numlock:enable"
        }
      }
      touchpad {
        tap
        natural-scroll
      }
    }

    output "eDP-1" {
      mode "1920x1080@60"
      position x=1920 y=1080
    }
    output "HDMI-A-1" {
      mode "1920x1080@60"
      position x=1920 y=0
    }
    output "DP-1" {
      mode "1920x1080@60"
      position x=0 y=0
    }

    include "colors.kdl"
    prefer-no-csd

    layout {
      gaps 16
      center-focused-column "never"
      focus-ring {
        active-color "#00000000"
      }
      
      preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
      }
      
      default-column-width { proportion 0.5; }
    }

    window-rule {
      geometry-corner-radius 5
      clip-to-geometry true
    }

    window-rule {
      match app-id="firefox" title="^Picture-in-Picture$"
      open-floating true
    }

    window-rule {
      match app-id="Thunar"
      open-floating true
    }

    window-rule {
      match app-id="Alacritty"
      open-floating true
      opacity 0.9
    }

    window-rule {
      match app-id="mpv"
      open-floating true
    }

    window-rule {
      match app-id="steam" title="Steam"
      open-maximized true
    }
    window-rule {
      match app-id="steam" title="Steam Settings"
      open-floating true
    }
    window-rule {
      match app-id="steam" title="Friends List"
      open-floating true
    }

    hotkey-overlay {
      skip-at-startup
    }

    binds {
      Mod+T { spawn "alacritty"; }
      Mod+L { spawn "loginctl" "lock-session"; }
      Mod+Space repeat=false { spawn "fuzzel"; }
      Mod+E { spawn "thunar"; }
      Mod+Escape { spawn "dms" "ipc" "call" "power-menu" "toggle"; }
      Mod+N { spawn "~/.local/bin/fuzzel-notes"; }
      Mod+P { spawn "~/.local/bin/fuzzel-powermenu"; }
      Mod+B { spawn "~/.local/bin/fuzzel-audio-out"; }
      Mod+Period { spawn "~/.local/bin/fuzzel-emoji"; }
      Mod+W { toggle-column-tabbed-display; }
      Mod+Q repeat=false { close-window; }
      
      Mod+Left  { focus-column-left; }
      Mod+Down  { focus-window-down; }
      Mod+Up    { focus-window-up; }
      Mod+Right { focus-column-right; }
      
      Mod+Shift+Left  { move-column-left; }
      Mod+Shift+Down  { move-window-down; }
      Mod+Shift+Up    { move-window-up; }
      Mod+Shift+Right { move-column-right; }
      
      Mod+Home { focus-column-first; }
      Mod+End  { focus-column-last; }
      
      Mod+WheelScrollDown      { focus-workspace-down; }
      Mod+WheelScrollUp        { focus-workspace-up; }
      Mod+Shift+WheelScrollDown { move-column-to-workspace-down; }
      Mod+Shift+WheelScrollUp   { move-column-to-workspace-up; }
      
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }

      Mod+Shift+1 { move-column-to-workspace 1; }
      Mod+Shift+2 { move-column-to-workspace 2; }
      Mod+Shift+3 { move-column-to-workspace 3; }
      Mod+Shift+4 { move-column-to-workspace 4; }
      Mod+Shift+5 { move-column-to-workspace 5; }
      Mod+Shift+6 { move-column-to-workspace 6; }
      Mod+Shift+7 { move-column-to-workspace 7; }
      Mod+Shift+8 { move-column-to-workspace 8; }
      Mod+Shift+9 { move-column-to-workspace 9; }
      
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+V { toggle-window-floating; }
      Mod+S { screenshot; }
      Print { screenshot; }
      Mod+Shift+E { quit; }
      
      XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
      XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
      XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
      
      XF86MonBrightnessUp   { spawn "brightnessctl" "set" "10%+"; }
      XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }
      
      XF86AudioPlay allow-when-locked=true { spawn "playerctl" "play-pause"; }
      XF86AudioNext allow-when-locked=true { spawn "playerctl" "next"; }
      XF86AudioPrev allow-when-locked=true { spawn "playerctl" "previous"; }
    }
  '';
}


