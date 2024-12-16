{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop.terminals.foot;
in
{
  options.myHome.desktop.terminals.foot = {
    enable = lib.mkOption {
      description = "Enable the foot terminal.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      TERMINAL = "footclient --title Terminal";
    };

    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "monospace:style=light:size=14";
          selection-target = "clipboard";
          workers = "4";
        };
        mouse = {
          hide-when-typing = "yes";
        };
        colors = with config.home.sessionVariables; {
          foreground = foreground;
          background = background;

          regular0 = black; 
          regular1 = red;  
          regular2 = green; 
          regular3 = yellow;
          regular4 = blue;  
          regular5 = magenta;
          regular6 = cyan;  
          regular7 = white; 
        
          bright0 = brightBlack;   
          bright1 = brightRed;    
          bright2 = brightGreen;   
          bright3 = brightYellow;  
          bright4 = brightBlue;   
          bright5 = brightMagenta; 
          bright6 = brightCyan;   
          bright7 = brightWhite;   
        };
      };
    };
  };
}

