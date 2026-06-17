{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.nb;
in
{
  options.myHome.cli.nb = {
    enable = lib.mkEnableOption "Enable the nb note-taking program.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nb
      openssl
    ];
  };
}

