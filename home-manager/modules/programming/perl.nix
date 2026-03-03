{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.perl;
in
{
  options.myHome.programming.languages.perl = {
    enable = lib.mkEnableOption "Enable the perl programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      perl
    ];
  };
}



