{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.chromium;
in
{
  options.myHome.browsers.chromium = {
    enable = lib.mkEnableOption "Enable and configure chromium.";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}

