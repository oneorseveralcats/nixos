{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.nushell;
in
{
  options.myHome.shells.nushell = {
    enable = lib.mkOption {
      description = "Enable the Nushell.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
    };
  };
}
