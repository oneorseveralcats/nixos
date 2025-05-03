{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.crystal;
in
{
  options.myHome.programming.languages.crystal = {
    enable = lib.mkEnableOption "Enable the crystal programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      crystal

      crystalline
    ];
  };
}


