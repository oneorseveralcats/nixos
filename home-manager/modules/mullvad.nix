{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.vpn.mullvad;
in
{
  options.myHome.vpn.mullvad = {
    enable = lib.mkEnableOption "Install the mullvad vpn app.";
  };

  config =  mkIf cfg.enable {
    home.packages = [
      pkgs.mullvad-vpn
    ];
  };
}

