{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.virtualization.podman;
in
{
  options.myConfig.virtualization.podman = {
    enable = lib.mkEnableOption "Enable podman container manager.";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
      };
    };
  };
}


