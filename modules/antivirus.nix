{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.antivirus;
in
{
  options.myConfig.antivirus = {
    enable = lib.mkOption {
      description = "Enable clamav antivirus";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.clamav = {
      daemon.enable = false;
      scanner.enable = false;
      updater.enable = false;
    };
  };
}

