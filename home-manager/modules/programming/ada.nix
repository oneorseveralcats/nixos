{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.ada;
in
{
  options.myHome.programming.languages.ada = {
    enable = lib.mkEnableOption "Enable the ADA programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnat
    ];
  };
}

