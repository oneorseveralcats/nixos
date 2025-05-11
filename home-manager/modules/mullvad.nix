{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.vpn.mullvad;
in
{
  options.myHome.vpn.mullvad = {
    enable = lib.mkOption {
      description = "Install the mullvad vpn app.";
      type = types.bool;
      default = false;
    };
  };

  config =  mkIf cfg.enable {
    home.packages = [
      pkgs.mullvad-vpn
    ];
  };
}

