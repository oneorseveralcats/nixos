{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop.terminals.foot;
in
{
  options.myHome.desktop.terminals.foot = {
    enable = lib.mkEnableOption "Enable the foot terminal.";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      TERMINAL = lib.mkDefault "footclient";
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

