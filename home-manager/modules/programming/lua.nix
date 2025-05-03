{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.lua;
  luaPkg = pkgs.lua.withPackages(ps: with ps; [ readline ]);
in
{
  options.myHome.programming.languages.lua = {
    enable = lib.mkEnableOption "Enable the lua programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      luaPkg
      lua-language-server
    ];
  };
}

