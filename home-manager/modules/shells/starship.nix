{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.starship;
in
{
  options.myHome.shells.starship = {
    enable = lib.mkEnableOption "Enable the Starship shell prompt.";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };
  };
}
