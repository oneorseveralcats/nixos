{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.tablet;
in
{
  options.myConfig.tablet = {
    enable = lib.mkOption {
      description = "Enable (better) drawing tablet support";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    services.input-remapper = {
      enable = true;
      enableUdevRules = true;
    };
  };
}

