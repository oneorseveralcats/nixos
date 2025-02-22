{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.qutebrowser;
in
{
  options.myHome.browsers.qutebrowser = {
    enable = lib.mkEnableOption "Enable and configure qutebrowser.";
  };

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
    };
  };
}

