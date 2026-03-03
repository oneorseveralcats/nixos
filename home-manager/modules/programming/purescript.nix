{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.purescript;
in
{
  options.myHome.programming.languages.purescript = {
    enable = lib.mkEnableOption "Enable the purescript programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      purescript spago 
    ];
  };
}

