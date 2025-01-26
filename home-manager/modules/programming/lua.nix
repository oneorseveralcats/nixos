{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.lua;
in
{
  options.myHome.programming.lua = {
    enable = lib.mkOption {
      description = "Enable the lua programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fennel lua
      lua-language-server
    ];
  };
}

