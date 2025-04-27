{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.sc-im;
in
{
  options.myHome.cli.sc-im = {
    enable = lib.mkEnableOption "Enable the sc-im spreadsheet program.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sc-im
    ];

    xdg.configFile."sc-im/scimrc".text = ''
    '';

  };
}


