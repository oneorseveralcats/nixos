{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.compositors.sway;
in
{
  options.myHome.desktop.compositors.sway = {
    enable = lib.mkOption {
      description = "Enable and configure the sway wayland compositor.";
      type = types.bool;
      default = false;
    };
  };

  config =  mkIf cfg.enable {
    myHome.desktop.compositors.wlr-extras.enable = true;
  
    wayland.windowManager.sway = {
      enable = true;
      checkConfig = false;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      extraSessionCommands = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export ANKI_WAYLAND=1
        export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export SDL_VIDEODRIVER=wayland
      '';
      config = {
        modifier = "Mod4";
        menu = "${pkgs.fuzzel}/bin/fuzzel | xargs swaymsg exec --";
        terminal = lib.mkDefault "footclient";
        left = "h";
        down = "n";
        up = "t";
        right = "s";
        workspaceAutoBackAndForth = true;
        fonts = {
          names = [ "monospace" ];
          style = "Light";
          # size = 14.0;
        };
        input."*" = {
          xkb_layout = "us,us";
          xkb_variant = "dvorak,";
          xkb_options = "altwin:prtsc_rwin,caps:swapescape,lv3:ralt_switch_multikey,esperanto:dvorak,grp:shifts_toggle";

          tap = "enabled";
          pointer_accel = "0.5";
          accel_profile = "adaptive";
        };
        output."*" = {
          resolution = "1920x1080@60Hz";
          # bg = "~/.wallpaper fit";
        };
        assigns = {
          "1:WEB" = [];
          "2:ANKI" = [
            { app_id = "^anki$"; }
            { instance = "^logseq$"; }
          ];
          "3:TERM" = [
            { app_id = "^foot$"; }
            { app_id = "^footclient$"; }
          ];
          "4:READ" = [
            { app_id = "^calibre-gui$"; }
            { app_id = "^org.pwmt.zathura$"; }
          ];
          "5:GAME" = [
            { class = "^Steam$"; }
            { app_id = "^Terraria.bin.x86_64$"; }
            { app_id = "^Patrick's Parabox.x86_64$"; }
            { app_id = ".*Baba Is You.*"; }
          ];
        };
        gaps = {
          inner = 2;
          outer = 2;
        };
        window = {
          border = 2;
          commands = [
            # focus on open
            { command = "focus"; criteria = { instance = "^logseq$"; } ; }
            { command = "focus"; criteria = { app_id = "^foot$"; } ; }
            { command = "focus"; criteria = { app_id = "^footclient$"; } ; }
            { command = "focus"; criteria = { app_id = "^org.pwmt.zathura$"; } ; }
            { command = "focus"; criteria = { app_id = "^Terraria.bin.x86_64$"; } ; }
            { command = "focus"; criteria = { app_id = "^Patrick's Parabox.x86_64$";} ; }
            { command = "focus"; criteria = { app_id = ".*Baba Is You.*"; } ; }

            { command = "sticky enable"; criteria = { app_id = "^mpv$"; } ; }
            { command = "move position 1400 660"; criteria = { app_id = "^mpv$"; } ; }

            { command = "resize set 400 500"; criteria = { title = "^n*sxiv$"; } ; }
            { command = "move position 1510 0"; criteria = { title = "^n*sxiv$"; } ; }
          
          ];
        };
        floating = {
          criteria = [
            { app_id = "^mpv$"; }
            { app_id = "^usbimager$"; }
            { title = "^n*sxiv$"; }
            { class = "^Pqiv$"; }
            { app_id = "^firefox$"; title = "^$"; }
            { app_id = "^syncplay$"; title = "^Set playlist \\(one per line\\)$"; }
            { app_id = "^syncplay$"; title = "^Add URLs to playlist \\(one per line\\)$"; }
            { app_id = "^syncplay$"; title = "^Directories to search for media$"; }
          ];
        };
        bindkeysToCode = true;
        defaultWorkspace = "workspace '1:WEB'";
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

          "${modifier}+1" = "workspace '1:WEB'";
          "${modifier}+2" = "workspace '2:ANKI'";
          "${modifier}+3" = "workspace '3:TERM'";
          "${modifier}+4" = "workspace '4:READ'";
          "${modifier}+5" = "workspace '5:GAME'";
          "${modifier}+6" = "workspace '6:DOC'";
          "${modifier}+7" = "workspace 7";
          "${modifier}+8" = "workspace 8";
          "${modifier}+9" = "workspace 9";
          "${modifier}+0" = "workspace 10";

          "${modifier}+Shift+1" = "move container to workspace '1:WEB'";
          "${modifier}+Shift+2" = "move container to workspace '2:ANKI'";
          "${modifier}+Shift+3" = "move container to workspace '3:TERM'";
          "${modifier}+Shift+4" = "move container to workspace '4:READ'";
          "${modifier}+Shift+5" = "move container to workspace '5:GAME'";
          "${modifier}+Shift+6" = "move container to workspace '6:DOC'";
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

          "${modifier}+Return" = "exec ${terminal} -T 'Terminal'";
          "${modifier}+Shift+Return" = "exec ${terminal} -a 'floating'";
          "${modifier}+d" = "exec ${menu}";
          # "${modifier}+m" = "exec mpvc -a \"$(wl-paste)\"";
          "${modifier}+m" = "exec ${pkgs.libnotify}/bin/notify-send 'mpvc' \"playlist: $(wl-paste) added.\" & mpvc -a \"$(wl-paste)\"";
          "${modifier}+Shift+m" = "exec ${pkgs.libnotify}/bin/notify-send 'mpv' \"opening $(wl-paste)\" & mpv \"$(wl-paste)\"";
          # "${modifier}+Shift+m" = "exec mpv \"$(wl-paste)\"";

          "${modifier}+Insert" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot -n copy anything";

          "--release Caps_Lock" = "exec swayosd-client --caps-lock";

          "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
          "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";

          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "XF86AudioMicMute" = "exec swayosd-client --input-volume mute-toggle";
          "XF86AudioRaiseVolume" =  "exec swayosd-client --output-volume raise --max-volume 150";
          "XF86AudioLowerVolume" =  "exec swayosd-client --output-volume lower --max-volume 150";

          "XF86AudioMedia" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioPlay" =  "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioPrev" =  "exec ${pkgs.playerctl}/bin/playerctl previous";
          "XF86AudioNext" =  "exec ${pkgs.playerctl}/bin/playerctl next";

          "${modifier}+F11" = "mode passthrough";
        };
        bars = [{ command = "none"; }];
        startup = [
          { command = "${pkgs.gammastep}/bin/gammastep -P -O 4000"; }
          { command = "${pkgs.xorg.xrdb}/bin/xrdb ~/.Xresources"; }
          { command = "mullvad-vpn --enable-features=useozoneplatform --ozone-platform=wayland"; }
          # { command = "logseq"; }
          { command = "${pkgs.lxsession}/bin/lxsession"; }
          # { command = "tmuxp load default"; }
          { command = "zellij -s multimedia -l multimedia"; }
          { command = "anki"; }
          { command = "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit"; }
        ];
      };
      extraConfig = ''
        hide_edge_borders --i3 smart
        set $gnome-schema org.gnome.desktop.interface
        exec_always {
      	  gsettings set $gnome-schema gtk-theme 'Adwaita-dark'
      	  gsettings set $gnome-schema icon-theme 'Adwaita'
      	  gsettings set $gnome-schema cursor-theme 'Adwaita'
        }
      '';
    };

    services.swayosd = {
      enable = true;
      topMargin = 0.5;
    };
  };
}
