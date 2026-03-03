{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.go;
in
{
  options.myHome.programming.languages.go = {
    enable = lib.mkEnableOption "Enable the Go programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      go
    ];
  };
}





