{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.starship;
in
{
  options.myHome.shells.starship = {
    enable = lib.mkOption {
      description = "Enable the Starship shell prompt.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };
  };
}
