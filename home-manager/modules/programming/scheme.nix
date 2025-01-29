{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.scheme;
in
{
  options.myHome.programming.languages.scheme = {
    enable = lib.mkOption {
      description = "Enable the scheme programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      guile
      racket
    ];
  };
}



