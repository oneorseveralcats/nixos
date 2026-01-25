{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.docker;
in
{
  options.myConfig.virtualization.docker = {
    enable = lib.mkEnableOption "Enable docker container manager.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker = {
        enable = true;
        # rootless.enable = true;
      };
    };
  };
}

