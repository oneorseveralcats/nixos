{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.d;
in
{
  options.myHome.programming.languages.d = {
    enable = lib.mkEnableOption "Enable the d programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      d
    ];
  };
}




