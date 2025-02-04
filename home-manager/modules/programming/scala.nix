{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.scala;
in
{
  options.myHome.programming.languages.scala = {
    enable = lib.mkOption {
      description = "Enable the Scala programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      scala metals
    ];
  };
}



