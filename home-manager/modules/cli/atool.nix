{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.atool;
in
{
  options.myHome.cli.atool = {
    enable = lib.mkEnableOption "atool a commandline archive tool.";
  };

  config = mkIf cfg.enable {
    programs.atool = {
      enable = true;
      extraPackages = with pkgs; [ bzip2 cpio gnutar gzip lhasa lzop p7zip unrar-free unzip xz zip ];
      settings.unrar_path = "unrar-free";
    };
  };
}
