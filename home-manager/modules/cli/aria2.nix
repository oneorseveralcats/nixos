{ config, lib, pkgs, ... }:
let 
  cfg = config.myHome.cli.aria2;
in
{
  options.myHome.cli.aria2 = {
    enable = lib.mkEnableOption "the aria2 download manager.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.python3Packages.aria2p
    ];

    programs.aria2 = {
      enable = true;
      settings = {
        dir = "${config.xdg.userDirs.download}";
        enable-rpc = true;
        rpc-listen-all = false;
      };
    };
  };
}
