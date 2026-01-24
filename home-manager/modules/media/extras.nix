{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.extras;
in
{
  options.myHome.media.extras = {
    enable = lib.mkEnableOption "Enable additional media packages.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      audacity
      easytag
      libjpeg libwebp
      mediainfo
      nicotine-plus 
      vorbis-tools
    ];
  };
}

