{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.fd;
in
{
  options.myHome.cli.fd = {
    enable = lib.mkEnableOption "fd.";
  };

  config = mkIf cfg.enable {
    programs.fd = {
      enable = true;
    };
  };
}
