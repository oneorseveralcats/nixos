{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.cobol;
in
{
  options.myHome.programming.languages.cobol = {
    enable = lib.mkEnableOption "Enable the COBOL programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnucobol
    ];
  };
}



