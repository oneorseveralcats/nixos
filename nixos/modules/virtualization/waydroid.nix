{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.waydroid;
in
{
  options.myConfig.virtualization.waydroid = {
    enable = lib.mkEnableOption "Enable waydroid android containers.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      waydroid = {
        enable = true;
      };
    };
  };
}



