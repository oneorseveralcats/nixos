{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.compositors.river;
in
{
  options.myHome.desktop.compositors.river = {
    enable = lib.mkEnableOption  "Enable the river wayland compositor.";
  };

  config = mkIf cfg.enable {
    myHome.desktop = {
      bars.waybar.enable = true;
      launchers.fuzzel.enable = true;

      autostart.wlr.enable = true;

      others = {
        mako.enable = true;
        swayidle.enable = true;
        swaylock.enable = true;
        wlr-packages.enable = true;
        wlr-portals.enable = true;
      };
    };

    wayland.windowManager.river = {
      enable = true;
      settings = {
        default-layout = "rivertile";
        border-width = 2;

        set-repeat = "50 300";
        spawn-tagmask = "$((2**31 - 1))";

        declare-mode = [
          "locked"
          "normal"
          "passthrough"
        ];
        keyboard-layout = ''-variant "dvorak," -options "caps:swapescape,lv3:ralt_switch_multikey,esperanto:dvorak,grp:shifts_toggle" "us,us"'';
        input = {
          "pointer-*" = {
            accel-profile = "adaptive";
            events = true;
            pointer-accel = 0.5;
            tap = true;
          };
        };
        map = {
          normal = {
            "Super+Shift Return" = "spawn foot";
            "Super d" = "spawn ${pkgs.fuzzel}/bin/fuzzel";
            "Super Insert" = ''spawn "${pkgs.sway-contrib.grimshot}/bin/grimshot -n copy anything"'';

            "None XF86AudioMedia" = "spawn '${pkgs.playerctl}/bin/playctl play-pause'";
            "None XF86AudioPlay"  = "spawn '${pkgs.playerctl}/bin/playctl play'";
            "None XF86AudioPause"  = "spawn '${pkgs.playerctl}/bin/playctl pause'";
            "None XF86AudioPrev"  = "spawn '${pkgs.playerctl}/bin/playctl previous'";
            "None XF86AudioNext"  = "spawn '${pkgs.playerctl}/bin/playctl next'";
            "None XF86AudioRaiseVolume"  = "spawn '${pkgs.pamixer}/bin/pamixer -i 5'";
            "None XF86AudioLowerVolume"  = "spawn '${pkgs.pamixer}/bin/pamixer -d 5'";
            "None XF86AudioMute"         = "spawn '${pkgs.pamixer}/bin/pamixer --toggle-mute'";
            "None XF86MonBrightnessUp"   = "spawn '${pkgs.brightnessctl}/bin/brightnessctl set +5%'";
            "None XF86MonBrightnessDown" = "spawn '${pkgs.brightnessctl}/bin/brightnessctl set 5%-'";
          
            "Super Space" = "toggle-float";
            "Super F" = "toggle-fullscreen";
      
            "Super+Shift Q" = "exit";
            "Super X" = "close";

            "Super Up"    = ''send-layout-cmd rivertile "main-location top"'';
            "Super Right" = ''send-layout-cmd rivertile "main-location right"'';
            "Super Down"  = ''send-layout-cmd rivertile "main-location bottom"'';
            "Super Left"  = ''send-layout-cmd rivertile "main-location left"'';

            "Super 1" =  "set-focused-tags $((2147483648 + 1))";
            "Super 2" =  "set-focused-tags $((2147483648 + 2))";
            "Super 3" =  "set-focused-tags $((2147483648 + 4))";
            "Super 4" =  "set-focused-tags $((2147483648 + 8))";
            "Super 5" =  "set-focused-tags $((2147483648 + 16))";
            "Super 6" =  "set-focused-tags $((2147483648 + 32))";
            "Super 7" =  "set-focused-tags $((2147483648 + 64))";
            "Super 8" =  "set-focused-tags $((2147483648 + 128))";
            "Super 9" =  "set-focused-tags $((2147483648 + 256))";

            "Super+Shift 1" = "set-view-tags 1";
            "Super+Shift 2" = "set-view-tags 2";
            "Super+Shift 3" = "set-view-tags 4";
            "Super+Shift 4" = "set-view-tags 8";
            "Super+Shift 5" = "set-view-tags 16";
            "Super+Shift 6" = "set-view-tags 32";
            "Super+Shift 7" = "set-view-tags 64";
            "Super+Shift 8" = "set-view-tags 128";
            "Super+Shift 9" = "set-view-tags 256";

            "Super+Control 1" = "toggle-focused-tags 1";
            "Super+Control 2" = "toggle-focused-tags 2";
            "Super+Control 3" = "toggle-focused-tags 4";
            "Super+Control 4" = "toggle-focused-tags 8";
            "Super+Control 5" = "toggle-focused-tags 16";
            "Super+Control 6" = "toggle-focused-tags 32";
            "Super+Control 7" = "toggle-focused-tags 64";
            "Super+Control 8" = "toggle-focused-tags 128";
            "Super+Control 9" = "toggle-focused-tags 256";

            "Super+Shift+Control 1" = "toggle-view-tags 1";
            "Super+Shift+Control 2" = "toggle-view-tags 2";
            "Super+Shift+Control 3" = "toggle-view-tags 4";
            "Super+Shift+Control 4" = "toggle-view-tags 8";
            "Super+Shift+Control 5" = "toggle-view-tags 16";
            "Super+Shift+Control 6" = "toggle-view-tags 32";
            "Super+Shift+Control 7" = "toggle-view-tags 64";
            "Super+Shift+Control 8" = "toggle-view-tags 128";
            "Super+Shift+Control 9" = "toggle-view-tags 256";

            "Super 0" = "set-focused-tags 4294967295";
            # "Super+Shift 0" = "set-view-tags 4294967295";

            # Always focused tab
            "Super+Shift 0" = "set-view-tags 2147483648";

            "Alt Tab" = "focus-previous-tags";
      
            "Super T" =  "focus-view next";
            "Super N" =  "focus-view previous";
            "Super+Shift T" = "swap next";
            "Super+Shift N" = "swap previous";

            "Super Period" = "focus-output next";
            "Super Comma" = "focus-output previous";

            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";

            "Super Return" = "zoom";

            "Super H" = ''send-layout-cmd rivertile "main-ratio -0.05"'';
            "Super S" = ''send-layout-cmd rivertile "main-ratio +0.05"'';

            "Super+Shift H" =  ''send-layout-cmd rivertile "main-count +1"'';
            "Super+Shift S" =  ''send-layout-cmd rivertile "main-count -1"'';

            "Super+Alt H" = "move left 100";
            "Super+Alt T" = "move down 100";
            "Super+Alt N" = "move up 100";
            "Super+Alt S" = "move right 100";

            "Super+Alt+Control H" = "snap left";
            "Super+Alt+Control T" = "snap down";
            "Super+Alt+Control N" = "snap up";
            "Super+Alt+Control S" = "snap right";

            "Super+Alt+Shift H" = "resize horizontal -100";
            "Super+Alt+Shift T" = "resize vertical 100";
            "Super+Alt+Shift N" = "resize vertical -100";
            "Super+Alt+Shift S" = "resize horizontal 100";

            "Super F11" = "enter-mode passthrough";
          };
          passthrough = {
            "Super F11" = "enter-mode normal";
          };
        };
        map-pointer = {
          normal = {
            "Super BTN_LEFT" = "move-view";
            "Super BTN_RIGHT" = "resize-view";
            "Super BTN_MIDDLE" = "toggle-float";
          };
        };
        rule-add = {
          "-app-id" = {
            "'bar'" = "csd";
            "'firefox'" = "ssd";
            "'mpv'" = [ "float" "position 1377 747" "tags 2147483648" ];
            "'usbimager'" = "float";
          };
          "-title" = {
            "'Authentication Required'" = "float";
          };
        };
        spawn = [
          "'${pkgs.gammastep}/bin/gammastep -P -O 4000'"
          "'mullvad-vpn --enable-features=useozoneplatform --ozone-platform=wayland'"
          "'${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent'"
        ];
        systemd.extraCommands = [
         "systemctl --user stop river-session.target"
         "systemctl --user start river-session.target"
        ];
      };
      extraSessionVariables = {
        _JAVA_AWT_WM_NONREPARENTING = "1";
        ANKI_WAYLAND = "1";
        MOZ_ENABLE_WAYLAND = "1";
        # QT_QPA_PLATFORM = "wayland-egl";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      extraConfig = /* sh */ ''
        rivertile -main-ratio 0.5 -view-padding 6 -outer-padding 6 &
      '';
    };

    myHome.stylix.enable = true;
    wayland.windowManager.river.settings = {
        # background-color = lib.mkForce "0x002b36";
        # border-color-focused = lib.mkForce "0x${config.lib.stylix.colors.base0D-hex}";
        border-color-unfocused = lib.mkForce "0x${config.lib.stylix.colors.base02-hex}";
    };
  };
}
