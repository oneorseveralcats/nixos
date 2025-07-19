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
        theme = "ao";
        simplified_ui = true;
        ui = {
          pane_frames.hide_session_name = true;
        };
      };
    };

    xdg.configFile."zellij/layouts/multimedia.kdl".text = ''
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

    xdg.configFile."zellij/layouts/programming.kdl".text = ''
      layout name="programming" {
      	default_tab_template {
      		pane name="tab-bar" size=1 borderless=true {
      	        plugin location="zellij:tab-bar"
      	  }
      		children
    	    pane name="status-bar" size=2 borderless=true {
    	        plugin location="zellij:status-bar"
    	    }
      	}

        tab name="Programming" {
          pane name="editor" size="80%"
          pane name="output" size="20%"
          
        }
      }
    '';
  };
}
