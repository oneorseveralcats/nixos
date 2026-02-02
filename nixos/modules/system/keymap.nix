{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.keymap;
in
{
  options.myConfig.system.keymap = {
    enable = mkEnableOption "Configure keyboard layout.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      keyd
    ];

    services.xserver.xkb = {
      layout = "us,us";
      options = "lv3:ralt_switch_multikey,esperanto:dvorak,grp:shifts_toggle";
      variant = "dvorak,";
    };
    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };

    services.keyd = {
      enable = true;
      keyboards = rec {
        default = {
          ids = [ "*" ];
          settings = {
            global = {
              overload_tap_timeout = "1000";
            };
            main = {
              "capslock" = "overload(control, esc)";
              "esc" = "capslock";
              "rightshift" = "rightshift"; # fixes xbkoption grp:shifts_toggle
            };
          };
        };
        t470s = {
          ids = [ "0001:0001:a38e6885" "0001:0001:70533846" "0001:0001:09b4e68d" ];
          settings = lib.recursiveUpdate default.settings {
            main = {
              "sysrq" = "layer(meta)";
            };
          };
        };
        matcha = {
          ids = [
            "3151:4011:5b3db59a"
            "3151:4015:7eff294f"
            "3151:4015:ab96504e"
          ];
          settings = lib.recursiveUpdate default.settings {
            main = {
              "esc" = "`";
              "S-esc" = "~";
              "`" = "capslock";
              "pause" = "delete";
            };
          };
        };
      };
    };
  };
}

