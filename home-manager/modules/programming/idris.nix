{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.idris;
in
{
  options.myHome.programming.languages.idris = {
    enable = lib.mkEnableOption "Enable the idris programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      idris2
    ];
  };
}


