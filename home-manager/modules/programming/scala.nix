{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.scala;
in
{
  options.myHome.programming.languages.scala = {
    enable = lib.mkEnableOption "Enable the Scala programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      scala metals
    ];
  };
}



