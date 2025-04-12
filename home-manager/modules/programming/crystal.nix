{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.crystal;
in
{
  options.myHome.programming.languages.crystal = {
    enable = lib.mkOption {
      description = "Enable the crystal programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      crystal

      crystalline
    ];
  };
}


