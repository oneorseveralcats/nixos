{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.cobol;
in
{
  options.myHome.programming.languages.cobol = {
    enable = lib.mkOption {
      description = "Enable the COBOL programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnucobol
    ];
  };
}



