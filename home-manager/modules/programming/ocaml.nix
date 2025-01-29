{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.ocaml;
in
{
  options.myHome.programming.languages.ocaml = {
    enable = lib.mkOption {
      description = "Enable the ocaml programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ocaml
      ocamlPackages.ocaml-lsp
    ];
  };
}


