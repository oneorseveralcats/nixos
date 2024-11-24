{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.gaming;
in
{
  options.myConfig.gaming = {
    enable = lib.mkOption {
      description = "Enable system-wide gaming packages";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
      programs.steam = {
        enable = true; 
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
  };
}
  
