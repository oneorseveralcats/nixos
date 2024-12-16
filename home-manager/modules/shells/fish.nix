
{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.fish;
in
{
  options.myHome.shells.fish = {
    enable = lib.mkOption {
      description = "Enable the fish.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
