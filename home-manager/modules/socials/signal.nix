{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.signal;
in
{
  options.myHome.socials.signal = {
    enable = lib.mkEnableOption "Enable the signal messaging client.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}

