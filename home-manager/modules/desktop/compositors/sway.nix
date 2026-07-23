{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.compositors.sway;
in
{
  options.myHome.desktop.compositors.sway = {
    enable = lib.mkEnableOption "and configure the sway wayland compositor.";
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
        swayosd.enable = true;
        wlr-packages.enable = true;
        wlr-portals.enable = true;
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      checkConfig = false;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      extraSessionCommands = /* sh */ ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export SDL_VIDEODRIVER=wayland
      '';
      config = {
        modifier = "Mod4";
        menu = "${pkgs.fuzzel}/bin/fuzzel | xargs swaymsg exec --";
        terminal = lib.mkDefault "foot";
        left = "h";
        down = "n";
        up = "t";
        right = "s";
        workspaceAutoBackAndForth = true;
        input = {
          "type:keyboard" = {
            xkb_layout = "us,us";
            xkb_variant = "dvorak,";
            xkb_options = "lv3:ralt_switch_multikey,esperanto:dvorak,grp:shifts_toggle";
          };

          "type:touchpad" = {
            tap = "enabled";
            pointer_accel = "0.5";
            accel_profile = "adaptive";
            drag_lock = "disabled";
          };

          "type:pointer" = {
            pointer_accel = "0.5";
            accel_profile = "adaptive";
          };

          "2:1:PS/2_Generic_Mouse" = {
            pointer_accel = "1.0";
            accel_profile = "adaptive";
          };

          # "2:7:SynPS/2_Synaptics_TouchPad" = {
          # };
        };
        output."*" = {
          resolution = "1920x1080@60Hz";
        };
        assigns = {
          "1" = [
            { app_id = "^ws1$"; }
            { app_id = "^ws1-focus$"; }
          ];
          "2" = [
            { app_id = "^anki$"; }
            { app_id = "^thunderbird$"; }
            { app_id = "^ws2$"; }
            { app_id = "^ws2-focus$"; }
            { instance = "^logseq$"; }
          ];
          "3" = [
            { app_id = "^foot$"; }
            { app_id = "^footclient$"; }
            { app_id = "^ws3$"; }
            { app_id = "^ws3-focus$"; }
          ];
          "4" = [
            { app_id = "^calibre-ebook-viewer$"; }
            { app_id = "^calibre-gui$"; }
            { app_id = "^org.pwmt.zathura$"; }
            { app_id = "^ws4$"; }
            { app_id = "^ws4-focus$"; }
            { app_id = "^YACReader$"; }
          ];
          "5" = [
            { app_id = "^Terraria.bin.x86_64$"; }
            { app_id = "^Patrick's Parabox.x86_64$"; }
            { app_id = ".*Baba Is You.*"; }
            { app_id = "^ws5$"; }
            { app_id = "^ws5-focus$"; }
            { class = "^steam$"; }
          ];
          "6" = [
            { app_id = "^ws6$"; }
            { app_id = "^ws6-focus$"; }
          ];
          "7" = [
            { app_id = "^ws7$"; }
            { app_id = "^ws7-focus$"; }
          ];
          "8" = [
            { app_id = "^ws8$"; }
            { app_id = "^ws8-focus$"; }
          ];
          "9" = [
            { app_id = "^ws9$"; }
            { app_id = "^ws9-focus$"; }
          ];
          "10" = [
            { app_id = "^ws10$"; }
            { app_id = "^ws10-focus$"; }
          ];
        };
        gaps = {
          inner = 2;
          outer = 2;
        };
        window = {
          titlebar = false;
          hideEdgeBorders = "--i3 smart";
          border = 2;
          commands = let
              video_xy = "";
              video_pos = "";
          in [
            # Focus on Open
            { command = "focus"; criteria = { app_id = "^ws1-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws2-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws3-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws4-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws5-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws6-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws7-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws8-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws9-focus$"; }; }
            { command = "focus"; criteria = { app_id = "^ws10-focus$"; }; }

            { command = "focus"; criteria = { instance = "^logseq$"; }; }
            { command = "focus"; criteria = { app_id = "^foot$"; }; }
            { command = "focus"; criteria = { app_id = "^footclient$"; }; }

            { command = "focus"; criteria = { app_id = "^org.pwmt.zathura$"; }; }
            { command = "focus"; criteria = { app_id = "^calibre-ebook-viewer$"; }; }
            { command = "focus"; criteria = { app_id = "^YACReader$"; }; }


            # Games
            { command = "focus"; criteria = { app_id = "^Terraria.bin.x86_64$"; }; }
            { command = "focus"; criteria = { app_id = "^Patrick's Parabox.x86_64$";}; }
            { command = "focus"; criteria = { app_id = ".*Baba Is You.*"; }; }


            {
              command = "resize set 1000 600, move position center";
              criteria = { title = "^Files$"; app_id = "floating"; };
            }

            {
              command = "sticky enable, resize set 480 270, move position 1400 660";
              criteria = { app_id = "^mpv$"; };
            }

            {
              command = "sticky enable, resize set 480 270, move position 1400 660";
              criteria = {
                app_id = "^firefox$";
                title = "^Picture-in-Picture$";
              };
            }

            {
              command = "resize set 500 150";
              criteria = { app_id = "^deluge$"; title = "^Add URl$"; };
            }

            {
              command = "sticky enable, resize set 485 125, move position 1460 380";
              criteria = { app_id = "^it.catboy.ripdrag$"; };
            }

            {
              command = "resize set 750 750, move position center";
              criteria = { app_id = "^firefox$"; title = "^Save As$"; };
            }

            {
              command = "resize set 400 500, move position 1510 0";
              criteria = { app_id = "^swayimg$"; };
            }
          ];
        };
        floating = {
          titlebar = false;
          criteria = [
            { app_id = "^mpv$"; }
            { app_id = "^swayimg$"; }
            { class = "^Pqiv$"; }

            { title = "^Bluetooth Devices$"; }

            { app_id = "^usbimager$"; }
            { app_id = "^io.gitlab.adhami3310.Impression$"; }

            { title = "^Authentication Required$"; }

            { app_id = "^it.catboy.ripdrag$"; }

            { app_id = "^calibre-gui$"; title = "^calibre$"; }

            { app_id = "^deluge$"; title = "^Add URL$"; }

            { app_id = "^firefox$"; title = "^$"; }
            { app_id = "^firefox$"; title = "^Picture-in-Picture$"; }

            { app_id = "^floating$"; }

            { app_id = "^syncplay$"; title = "^Set playlist \\(one per line\\)$"; }
            { app_id = "^syncplay$"; title = "^Add URLs to playlist \\(one per line\\)$"; }
            { app_id = "^syncplay$"; title = "^Directories to search for media$"; }
          ];
        };
        bindkeysToCode = true;
        defaultWorkspace = "workspace 1";
        keybindings = with config.wayland.windowManager.sway.config; {
          "${modifier}+Shift+q" = "exec swaynag -t warning -m 'Exit Sway?' -b 'Yes.' 'swaymsg exit'";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+x" = "kill";

    			"${modifier}+Up" = "opacity plus 0.1";
    			"${modifier}+Down" = "opacity minus 0.1";

          "${modifier}+${up}" = "focus up";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${left}" = "focus left";
          "${modifier}+${right}" = "focus right";

          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${right}" = "move right";

          "${modifier}+a" = "workspace back_and_forth";

          "${modifier}+1" = "workspace 1";
          "${modifier}+2" = "workspace 2";
          "${modifier}+3" = "workspace 3";
          "${modifier}+4" = "workspace 4";
          "${modifier}+5" = "workspace 5";
          "${modifier}+6" = "workspace 6";
          "${modifier}+7" = "workspace 7";
          "${modifier}+8" = "workspace 8";
          "${modifier}+9" = "workspace 9";
          "${modifier}+0" = "workspace 10";

          "${modifier}+Shift+1" = "move container to workspace 1";
          "${modifier}+Shift+2" = "move container to workspace 2";
          "${modifier}+Shift+3" = "move container to workspace 3";
          "${modifier}+Shift+4" = "move container to workspace 4";
          "${modifier}+Shift+5" = "move container to workspace 5";
          "${modifier}+Shift+6" = "move container to workspace 6";
          "${modifier}+Shift+7" = "move container to workspace 7";
          "${modifier}+Shift+8" = "move container to workspace 8";
          "${modifier}+Shift+9" = "move container to workspace 9";
          "${modifier}+Shift+0" = "move container to workspace 10";

          "${modifier}+c" = "split toggle";
          "${modifier}+g" = "layout tabbed";
          "${modifier}+f" = "fullscreen";

          "${modifier}+comma" = "focus parent";
          "${modifier}+period" = "focus child";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

  	      "${modifier}+Ctrl+space" =	"sticky toggle";
  	      "${modifier}+Shift+minus" =	"move scratchpad";
  	      "${modifier}+minus" = "scratchpad show";

          "${modifier}+r" = "mode resize";

          "${modifier}+Return" =
            if config.myHome.cli.zellij.enable then
              "exec " + pkgs.writeShellScript "focus-zellij" ''
                ${config.programs.zellij.package}/bin/zellij --session zellij-default action new-tab -n term
                swaymsg '[title="^zellij-default$"] focus'
              ''
            else
              "exec ${terminal} --title='Terminal'";
          "${modifier}+Shift+Return" = "exec ${terminal} --title='Terminal'";
          "${modifier}+Ctrl+Shift+Return" = "exec ${terminal} --title='Terminal' --app-id='floating'";
          "${modifier}+Shift+f" = "exec " + pkgs.writers.writeBash "show-hide-fm" ''
            swaymsg [title="^Files$"] scratchpad show\
            || swaymsg [title="^Files$"] move container to scratchpad\
            || ${terminal} --title='Files' --app-id='floating' -- lf && swaymsg sticky enable
          '';
          "${modifier}+d" = "exec ${menu}";

          "${modifier}+m" = "exec ${pkgs.libnotify}/bin/notify-send 'mpv' \"opening $(wl-paste)\" & mpv \"$(wl-paste)\"";
          "${modifier}+Shift+m" = "exec " + pkgs.writers.writeBash "show-video-scratchpad" ''
            swaymsg [app_id="^mpv$"] scratchpad show
          '';
          # "${modifier}+m" = "exec ${pkgs.libnotify}/bin/notify-send 'mpvc' \"playlist: $(wl-paste) added.\" & mpvc -a \"$(wl-paste)\"";
          # "${modifier}+Shift+m" = "exec ${pkgs.libnotify}/bin/notify-send 'mpv' \"opening $(wl-paste)\" & mpv \"$(wl-paste)\"";
          "${modifier}+Insert" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot -n copy anything";

          "--release Caps_Lock" = "exec swayosd-client --caps-lock";

          "XF86MonBrightnessUp" = "exec " + pkgs.writers.writeBash "brightnessRaise" ''
            percent="$(brightnessctl -m | cut -d, -f4)"
            case $percent in
              0%) brightnessctl s 1%;;
              1%) brightnessctl s 5%;;
               *) brightnessctl s 5%+;;
            esac
          '';
          "XF86MonBrightnessDown" = "exec " + pkgs.writers.writeBash "brightnessLower" ''
            percent="$(brightnessctl -m | cut -d, -f4)"
            case $percent in
              1%) brightnessctl s 0%;;
              5%) brightnessctl s 1%;;
               *) brightnessctl s 5%-;;
            esac
          '';

          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "XF86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";
          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise --max-volume 150";
          "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower --max-volume 150";

          "XF86AudioMedia" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioPlay"  = "exec ${pkgs.playerctl}/bin/playerctl play";
          "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
          "XF86AudioPrev"  = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "XF86AudioNext"  = "exec ${pkgs.playerctl}/bin/playerctl next";

          "${modifier}+b" = let
            toggleBar = pkgs.writers.writeBash "toggleBar" ''
                if [ "$(swaymsg -t get_bar_config bar-0 | jq -r ".mode")" = "dock" ]; then
                  swaymsg bar mode invisible
                else
                  swaymsg bar mode dock
                fi
              '';
          in ''exec ${toggleBar}'';

          "${modifier}+F11" = "mode passthrough";
        };
        modes = with config.wayland.windowManager.sway.config; {
          passthrough = {
            "${modifier}+F11" = "mode default";
          };
          resize = {
            "${left}" = "resize shrink width 10 px";
            "${down}" = "resize grow height 10 px";
            "${up}" = "resize shrink height 10 px";
            "${right}" = "resize grow width 10 px";

            "Left" = "resize shrink width 10 px";
            "Down" = "resize grow height 10 px";
            "Up" = "resize shrink height 10 px";
            "Right" = "resize grow width 10 px";

            # Exit resize mode
            "Escape" = "mode default";
            "Return" = "mode default";
          };
        };
        bars = [{ command = "none"; }];
        startup = [
          { command = "${pkgs.swaynag-battery}/bin/swaynag-battery --threshold 20"; }
          { command = "sleep 5s; ${pkgs.foot}/bin/foot -- ${pkgs.zellij}/bin/zellij attach -f zellij-default"; }
        ];
      };
    };

    myHome.stylix.enable = true;
    wayland.windowManager.sway.config = {
      fonts.names = lib.mkForce [ config.stylix.fonts.monospace.name ];
      colors = {
        focused = rec {
          background = lib.mkForce "#${config.lib.stylix.colors.base04-hex}";
          border = background;
          text = lib.mkForce "#${config.lib.stylix.colors.base00-hex}";
          # indicator = lib.mkForce "#${config.lib.stylix.colors.base03-hex}";
        };
        focusedInactive.border = lib.mkForce "#${config.lib.stylix.colors.base0D-hex}";
        unfocused.border = lib.mkForce "#${config.lib.stylix.colors.base02-hex}";
      };
    };
  };
}
