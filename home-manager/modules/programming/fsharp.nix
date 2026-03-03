{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.fsharp;
in
{
  options.myHome.programming.languages.fsharp = {
    enable = lib.mkEnableOption "Enable the fsharp programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fsharp
    ];
  };
}


