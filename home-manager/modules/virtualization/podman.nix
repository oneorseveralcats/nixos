{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.podman;
in
{
  options.myHome.podman = {
    enable = lib.mkEnableOption "Enable podman container manager.";
  };

  config = mkIf cfg.enable {
    services.podman = {
      enable = true;
    };
  };
}


