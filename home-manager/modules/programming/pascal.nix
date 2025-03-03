{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.pascal;
in
{
  options.myHome.programming.languages.pascal = {
    enable = lib.mkEnableOption "Enable the Pascal programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fpc
    ];

    programs.nixvim.plugins.lsp.servers.pasls = {
      enable = true;
      package = null;
    };
  };
}

