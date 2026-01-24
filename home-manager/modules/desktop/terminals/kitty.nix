{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop.terminals.kitty;
in
{
  options.myHome.desktop.terminals.kitty = {
    enable = lib.mkEnableOption "Enable the kitty terminal.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
    };
  };
}

