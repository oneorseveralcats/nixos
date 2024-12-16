{ config, lib, ...}:
with lib;
let 
  cfg = config.myHome.desktop.terminals.kitty;
in
{
  options.myHome.desktop.terminals.kitty = {
    enable = lib.mkOption {
      description = "Enable the kitty terminal.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
    };
  };
}

