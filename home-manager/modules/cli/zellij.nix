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
        mouse_mode = false;
        simplified_ui = true;
        theme = "catppuccin-mocha";
        themes.custom = with config.home.sessionVariables; {
          fg = "#${foreground}";
          bg = "#${background}";
          black = "#${black}";
          red = "#${red}";
          green = "#${green}";
          yellow = "#${yellow}";
          blue = "#${blue}";
          magenta = "#${magenta}";
          cyan = "#${cyan}";
          white = "#${white}";
          orange = "#${brightRed}";
        };
        ui = {
          pane_frames.hide_session_name = true;
        };
      };
    };
    home.file.".config/zellij/layouts/multimedia.kdl" = {
      text = ''
        layout name="multimedia" {
        	default_tab_template {
        		pane name="tab-bar" size=1 borderless=true {
        	        plugin location="zellij:tab-bar"
        	    }
        		children
        	    pane name="status-bar" size=2 borderless=true {
        	        plugin location="zellij:status-bar"
        	    }
        	}

        	tab name="ncmpcpp" {
        		pane command="ncmpcpp"
        	}
        	tab name="newsboat" {
        		pane command="newsboat"
        	}
        	tab name="audio" split_direction="horizontal" {
        		pane command="pulsemixer"
        		pane command="bluetuith"
        	}
        	tab name="background" {
        		pane {
              command "bash"
              args "-c" "while true; do ~/projects/programming/rssfeed_hackery/run.sh; sleep 1h; done"
            }
        	}
        }
      '';
    };
  };
}
