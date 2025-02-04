{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.dotnet;
in
{
  options.myHome.programming.languages.dotnet = {
    enable = lib.mkOption {
      description = "Enable the dotnet framework and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dotnet-sdk
    ];
  };
}



