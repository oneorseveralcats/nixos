{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.java;
in
{
  options.myHome.programming.java = {
    enable = lib.mkOption {
      description = "Enable the java programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      openjdk
      jdt-language-server
    ];
  };
}


