{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.extras;
in
{
  options.myHome.media.extras = {
    enable = lib.mkOption {
      description = "Enable additional media packages.";
      type = types.bool;
      default = true;
    };
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

