{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.perl;
in
{
  options.myHome.programming.languages.perl = {
    enable = lib.mkOption {
      description = "Enable the perl programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      perl perlnavigator
    ];
  };
}



