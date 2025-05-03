{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.prolog;
in
{
  options.myHome.programming.languages.prolog = {
    enable = lib.mkEnableOption "Enable the prolog programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swi-prolog
    ];
  };
}




