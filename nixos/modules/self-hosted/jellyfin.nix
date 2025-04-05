{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.self-hosted.jellyfin;
in
{
  options.myConfig.self-hosted.jellyfin = {
    enable = mkEnableOption "Enable the Jellyfin Media Server.";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}


