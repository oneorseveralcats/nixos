{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.java;
in
{
  options.myHome.programming.languages.java = {
    enable = lib.mkEnableOption "Enable the java programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      openjdk
      jdt-language-server
    ];
  };
}


