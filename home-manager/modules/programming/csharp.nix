{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.dotnet;
in
{
  options.myHome.programming.languages.dotnet = {
    enable = lib.mkEnableOption "Enable the dotnet framework and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dotnet-sdk
      omnisharp-roslyn
    ];
  };
}



