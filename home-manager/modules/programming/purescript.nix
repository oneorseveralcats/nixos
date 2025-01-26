{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.purescript;
in
{
  options.myHome.programming.languages.purescript = {
    enable = lib.mkOption {
      description = "Enable the purescript programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      purescript spago 
    ];
  };
}

