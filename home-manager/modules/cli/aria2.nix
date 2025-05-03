{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.aria2;
in
{
  options.myHome.cli.aria2 = {
    enable = lib.mkEnableOption "Enable the aria2 download manager.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.python3Packages.aria2p
    ];

    programs.aria2 = {
      enable = true;
      settings = {
        enable-rpc = true;
        rpc-listen-all = false;
      };
    };
  };
}
