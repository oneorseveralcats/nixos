{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.aria2;
in
{
  options.myHome.cli.aria2 = {
    enable = lib.mkOption {
      description = "Enable the aria2 download manager.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.aria2 = {
      enable = true;
      settings = {
        enable-rpc = true;
        rpc-listen-all = false;
      };
    };
  };
}
