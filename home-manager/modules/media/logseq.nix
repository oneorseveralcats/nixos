{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.logseq;
in
{
  options.myHome.media.logseq = {
    enable = lib.mkEnableOption "Enable the logseq notetaking application.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.unstable.logseq
    ];
  };
}

