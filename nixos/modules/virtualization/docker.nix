{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.docker;
in
{
  options.myConfig.virtualization.docker = {
    enable = lib.mkOption {
      description = "Enable docker container manager.";
      type = types.bool;
      default = false;
    };
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

