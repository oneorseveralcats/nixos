{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.elm;
in
{
  options.myHome.programming.languages.elm = {
    enable = lib.mkEnableOption "Enable the elm programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      elmPackages.elm
      elmPackages.elm-language-server
    ];
  };
}

