{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.racket;
in
{
  options.myHome.programming.languages.racket = {
    enable = lib.mkEnableOption "Enable the racket programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      racket
    ];
  };
}

