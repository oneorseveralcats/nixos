{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.bars.waybar;
in
{
  options.myHome.desktop.bars.waybar = {
    enable = lib.mkEnableOption "and configure waybar.";
  };

  config =  mkIf cfg.enable {
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

    myHome.stylix.enable = true;
    programs.waybar.style = /* css */ ''
      .modules-left #workspaces button:hover,
      .modules-left #tags button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      .modules-left #workspaces button,
      .modules-left #tags button {
        color: @base05;
        padding: 0 3px;
      }

      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active,
      .modules-left #tags button.focused,
      .modules-left #tags button.active {
        border-bottom-color: @base0D;
        color: @base0D;
      }

      .modules-left #workspaces button.urgent,
      .modules-left #tags button.urgent {
        background-color: @base00;
        border-bottom-color: @base08;
        color: @base08;
      }

      .modules-left #workspaces button.empty,
      .modules-left #tags button:not(.occupied):not(.focused) {
        color: @base02;
      }

      .modules-left #workspaces label {
        font-weight: normal;
      }

      .modules-left widget label#mode {
        margin-left: 0.25em;
        color: @base08;
      }

      .modules-right widget {
        border-left: 1.25px solid @base05;
        border-bottom: 15px solid transparent;
        border-top: 15px solid transparent;
        padding-left: 5px;
        padding-right: 5px;
      }

      .modules-right box#tray widget {
        border-left: 0;
      }

      .modules-right box#tray {
        padding-left: 5px;
      }

      .modules-right #custom-sep {
        font-weight: bold;
        padding-left: 2px;
        padding-right: 2px;
      }
    '';
  };
}
