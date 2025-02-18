{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.socials.signal;
in
{
  options.myHome.socials.signal = {
    enable = lib.mkOption {
      description = "Enable signal.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}

