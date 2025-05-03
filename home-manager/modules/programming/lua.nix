{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.lua;
in
{
  options.myHome.programming.languages.lua = {
    enable = lib.mkEnableOption "Enable the lua programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fennel lua
      lua-language-server
    ];
  };
}

