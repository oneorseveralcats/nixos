{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.miranda;
in
{
  options.myHome.programming.languages.miranda = {
    enable = lib.mkEnableOption "Enable the Miranda programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      miranda
    ];
  };
}



