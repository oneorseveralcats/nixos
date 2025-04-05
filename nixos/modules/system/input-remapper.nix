{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.input-remapper;
in
{
  options.myConfig.system.input-remapper = {
    enable = lib.mkOption {
      description = "Enable input-remapper, a tool remapping the buttons on input devices (like drawing tablets).";
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

