{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.python;
in
{
  options.myHome.programming.languages.python = {
    enable = lib.mkEnableOption "Enable the python programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
      python3Packages.python-lsp-server
    ];
  };
}
