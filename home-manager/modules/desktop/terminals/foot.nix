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
          selection-target = "clipboard";
          workers = "4";
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}

