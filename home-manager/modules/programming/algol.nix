{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.algol;
in
{
  options.myHome.programming.languages.algol = {
    enable = lib.mkEnableOption "Enable the ALGOL 60/68 programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      algol68g marst
    ];
  };
}



