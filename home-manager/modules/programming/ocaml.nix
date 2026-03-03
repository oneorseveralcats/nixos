{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.ocaml;
in
{
  options.myHome.programming.languages.ocaml = {
    enable = lib.mkEnableOption "Enable the ocaml programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ocaml
    ];
  };
}


