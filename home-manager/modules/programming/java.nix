{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.java;
in
{
  options.myHome.programming.languages.java = {
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


