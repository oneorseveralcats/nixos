{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.dart;
in
{
  options.myHome.programming.languages.dart = {
    enable = lib.mkEnableOption "Enable the dart programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dart
    ];
  };
}



