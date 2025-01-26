{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.purescript;
in
{
  options.myHome.programming.purescript = {
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

