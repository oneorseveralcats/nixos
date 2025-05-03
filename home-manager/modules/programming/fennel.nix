{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.fennel;
in
{
  options.myHome.programming.languages.fennel = {
    enable = lib.mkEnableOption "Enable the fennel programming language and tools.";
  };

  config = mkIf cfg.enable {
    myHome.programming.languages.lua.enable = true;

    home.packages = with pkgs; [
      fennel
      fennel-ls
    ];
  };
}


