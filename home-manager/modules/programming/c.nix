{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.c;
in
{
  options.myHome.programming.languages.c = {
    enable = lib.mkEnableOption "Enable the C/C++ programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
    ];
  };
}


