{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop.terminals.alacritty;
in
{
  options.myHome.desktop.terminals.alacritty = {
    enable = lib.mkOption {
      description = "Enable the alacritty terminal.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };
  };
}

