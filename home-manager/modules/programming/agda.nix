{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.agda;
in
{
  options.myHome.programming.languages.agda = {
    enable = lib.mkEnableOption "Enable the agda programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      agda
    ];
  };
}


