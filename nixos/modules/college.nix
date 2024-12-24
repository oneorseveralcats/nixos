{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.college;
in
{
  options.myConfig.college = {
    enable = lib.mkOption {
      description = "Enable things specifically for college";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
  };
}

