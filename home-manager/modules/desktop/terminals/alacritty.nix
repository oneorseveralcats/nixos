{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop.terminals.alacritty;
in
{
  options.myHome.desktop.terminals.alacritty = {
    enable = lib.mkEnableOption "Enable the alacritty terminal.";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };
  };
}

