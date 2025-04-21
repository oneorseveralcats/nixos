{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.prolog;
in
{
  options.myHome.programming.languages.prolog = {
    enable = lib.mkOption {
      description = "Enable the prolog programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swi-prolog
    ];
  };
}




