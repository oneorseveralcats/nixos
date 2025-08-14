{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.antivirus;
in
{
  options.myConfig.antivirus = {
    enable = lib.mkEnableOption "Enable clamav antivirus";
  };

  config = mkIf cfg.enable {
    services.clamav = {
      daemon.enable = true;
      scanner.enable = true;
      updater.enable = true;
    };
  };
}

