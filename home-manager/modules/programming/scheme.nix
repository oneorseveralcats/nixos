{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.languages.scheme;
in
{
  options.myHome.programming.languages.scheme = {
    enable = lib.mkEnableOption "Enable the scheme programming language and tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      guile
    ];

    home.file.".guile".text = /* scheme */ ''
      (use-modules (ice-9 readline))
      (activate-readline)
    '';
      
  };
}

