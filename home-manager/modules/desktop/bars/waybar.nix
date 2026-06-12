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
      systemd = {
        enable = true;
        targets = [
          "river-session.target"
          "sway-session.target"
        ];
      };
      settings = {
        mainBar = {
          id = "bar-0";
          ipc = true;
          height = 25;
          position = "top";
          reload_style_on_change = true;
          modules-left = [ "sway/workspaces" "sway/mode" "river/tags" "river/mode" ];
          modules-center = [ "clock#time" ];
          modules-right = let
            sep = "custom/separator";
            addSeparator = xs: [ sep ] ++ lib.intersperse sep xs;
          in addSeparator [ "sway/language" "clock#date" "battery" "tray" ];

          "sway/language" = {
            format = "{short} {variant}";
            tooltip = false;
          };

          "sway/workspaces" = {
            disable-scoll = true;
            format = "{index}";
            persistent-workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
              "6" = [];
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

          "custom/separator" = {
            format = "|";
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
            icon-size = 22;
            spacing = 3;
          };
        };
      };
    };

    myHome.stylix.enable = true;
    programs.waybar.style = /* css */ ''
      .modules-left #workspaces button:hover,
      .modules-left #tags button:hover {
        background: none;
        box-shadow: none;
        text-shadow: none;
        transition: none;
      }

      .modules-left #workspaces button,
      .modules-left #tags button {
        border: 0;
        color: @base05;
        padding: 0 3px;
      }

      .modules-left #workspaces button.empty,
      .modules-left #tags button:not(.occupied):not(.focused) {
        color: @base03;
      }

      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active,
      .modules-left #tags button.focused,
      .modules-left #tags button.active {
        color: @base0D;
      }

      .modules-left #workspaces button.urgent,
      .modules-left #tags button.urgent {
        color: @base08;
      }

      .modules-left #workspaces label {
        font-weight: normal;
      }

      .modules-left widget label#mode {
        margin-left: 0.25em;
        color: @base08;
      }

      .modules-right #custom-separator {
        padding-left: 2px;
        padding-right: 2px;
      }
    '';
  };
}
