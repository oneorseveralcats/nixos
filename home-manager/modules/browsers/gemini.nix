{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.browsers.gemini;
in
{
  options.myHome.browsers.gemini = {
    enable = lib.mkEnableOption "Enable and configure gemini browsers.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      amfora
      lagrange
    ];
  };
}

