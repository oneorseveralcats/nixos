{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.virtualization.podman;
in
{
  options.myHome.virtualization.podman = {
    enable = lib.mkEnableOption "Enable podman container manager.";
  };

  config = mkIf cfg.enable {
    services.podman = {
      enable = true;
    };
  };
}


