{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.desktop.steam;
in
{
  options.myConfig.desktop.steam = {
    enable = lib.mkOption {
      description = "Enable Steam.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      protontricks      
    ];

    programs.steam = {
      enable = true; 
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
}
  
