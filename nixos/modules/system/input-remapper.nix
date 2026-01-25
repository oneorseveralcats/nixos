{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.system.input-remapper;
in
{
  options.myConfig.system.input-remapper = {
    enable = lib.mkEnableOption "Enable input-remapper, a tool remapping the buttons on input devices (like drawing tablets).";
  };

  config = mkIf cfg.enable {
    services.input-remapper = {
      enable = true;
      enableUdevRules = true;
    };
  };
}

