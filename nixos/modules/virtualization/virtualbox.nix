{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.virtualbox;
in
{
  options.myConfig.virtualization.virtualbox = {
    enable = lib.mkEnableOption "Enable virtualbox.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      virtualbox = {
        host = {
          enable = true;
        };
      };
    };
  };
}



