{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.python;
in
{
  options.myHome.programming.languages.python = {
    enable = lib.mkOption {
      description = "Enable the python programming language and tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
      python3Packages.python-lsp-server
    ];
  };
}
