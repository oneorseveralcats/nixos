{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.smalltalk;
in
{
  options.myHome.programming.languages.smalltalk = {
    enable = lib.mkEnableOption "Enable the Smalltalk programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnusmalltalk
      squeak
    ];
  };
}


