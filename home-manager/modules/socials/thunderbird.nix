{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.thunderbird;
in
{
  options.myHome.socials.thunderbird = {
    enable = lib.mkEnableOption "Enable the thunderbird email client.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      thunderbird
    ];
  };
}


