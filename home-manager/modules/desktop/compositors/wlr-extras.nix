{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.compositors.wlr-extras;
in
{
  options.myHome.desktop.compositors.wlr-extras = {
    enable = lib.mkOption {
      description = "Enable extra programs and services for wlroots compositors.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grim 
      slurp 
      xdragon
      wf-recorder wl-clipboard wl-clipboard-x11 
      wev wlprop
    ];

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.foot}/bin/foot";
          list-executables-in-path = true;
        };
      };
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          height = 35;
          position = "top";
          reload_style_on_change = true;
          modules-left = [ "sway/workspaces" "sway/mode" "river/tags" "river/mode" ];
          modules-center = [ "sway/window" "river/window" ];
          modules-right = lib.mkDefault [ "sway/language" "clock#date" "clock#time" "battery" "tray" ];

          "sway/language" = {
            format = "{short} {variant}";
            tooltip = false;
          };

          "sway/workspaces" = {
            disable-scoll = true;
            format = "{index}";
            persistent-workspaces = {
              "1:WEB" = [];
              "2:ANKI" = [];
              "3:TERM" = [];
              "4:READ" = [];
              "5:GAME" = [];
              "6:DOC" = [];
              "7" = [];
              "8" = [];
              "9" = [];
              "10" = [];
            };
          };
          "sway/window" = {
            max-length = 30;
          };

          "river/tags" = {
            "set-tags" = [
              2147483649
              2147483650
              2147483652
              2147483656
              2147483664
              2147483680
              2147483712
              2147483776
              2147483904
            ];
          };
          "river/window" = {
            max-length = 30;
          };

          "clock#date" = {
            format = "{:%m/%d}";
            tooltip = false;
          };
          "clock#time" = {
            format = "{:%R}";
            tooltip = false;
          };
          "tray" = {
            icon-size = 25;
            spacing = 5;
          };
        };
      };
    };

    services.mako = {
      enable = true;
      settings = {
        default-timeout = 15000;
        width = 500;
        height = 500;
        border-size = 2;
      };
    };

    services.swayidle = {
      enable = true;
      events = [
        { 
          event = "before-sleep"; 
          command = "${pkgs.playerctl}/bin/playerctl pause; ${pkgs.swaylock}/bin/swaylock";
        }
        { 
          event = "lock"; 
          command = "${pkgs.swaylock}/bin/swaylock";
        }
      ];
      timeouts = [
        { 
          timeout = 3600; 
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        { 
          timeout = 3660;
          command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
        }
      ];
    };

    programs.swaylock = {
      enable = true;
      settings = {
        daemonize = true;
        hide-keyboard-layout = true;
      };
    };

    xdg.portal = {
      enable = true;
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
        sway = {
          default = [
            "wlr"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
      };
      extraPortals = with pkgs; [
        gnome-keyring
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}
