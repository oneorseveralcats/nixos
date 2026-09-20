{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.zellij;
in
{
  options.myHome.cli.zellij = {
    enable = lib.mkEnableOption "Enable the Zellij terminal multiplexer.";
  };

  config = mkIf cfg.enable {
    home.shellAliases = {
      ze = "${pkgs.zellij}/bin/zellij";
    };

    programs.zellij = {
      enable = true;
      settings = {
        simplified_ui = true;
        show_startup_tips = false;
        ui = {
          pane_frames.hide_session_name = true;
        };
      };
    };

    programs.zellij.layouts = rec {
      default.layout._children = [
        {
          default_tab_template._children = [
            {
              pane = {
                size = 1;
                borderless = true;
                plugin.location = "zellij:tab-bar";
              };
            }
            { "children" = { }; }
            {
              pane = {
                size = 1;
                borderless = true;
                plugin.location = "zellij:status-bar";
              };
            }
          ];
        }
      ];
      startup.layout._children = default.layout._children ++ [
        {
          tab = {
            _props.name = "music";
            _children = [{ pane.command = "ncmpcpp"; }];
          };
        }
        {
          tab = {
            _props.name = "yt";
            _children = [{ pane.command = "nom"; }];
          };
        }
        {
          tab = {
            _props.name = "vol";
            _children = [{ pane.command = "pulsemixer"; }];
          };
        }
      ];
    };

    programs.zellij.themes = with config.lib.stylix.colors.withHashtag; {
      stylix.themes.default = {
        frame_selected.base = lib.mkForce base0D;
        ribbon_selected.background = lib.mkForce base0D;
        ribbon_unselected.emphasis_1 = lib.mkForce base01;
        table_title.base = lib.mkForce base0D;
      };
    };
  };
}
