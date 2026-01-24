{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.college;
in
{
  options.myHome.college = {
    enable = lib.mkEnableOption "Enable packages and settings that are needed by college courses.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jflap 
    ];
  };
}
