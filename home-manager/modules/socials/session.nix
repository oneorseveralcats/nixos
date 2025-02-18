{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.session;
in
{
  options.myHome.socials.session = {
    enable = lib.mkEnableOption "Enable the session messaging client.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      session-desktop
    ];
  };
}

