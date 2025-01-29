{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.idris;
in
{
  options.myHome.programming.languages.idris = {
    enable = lib.mkOption {
      description = "Enable the idris programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      idris2
      idris2Packages.idris2Lsp
    ];
  };
}


