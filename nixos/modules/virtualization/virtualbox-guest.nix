{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.virtualbox.guest;
in
{
  options.myConfig.virtualization.virtualbox.guest = {
    enable = lib.mkEnableOption "Enable virtualbox.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      virtualbox.guest.enable = true;
    };
  };
}



