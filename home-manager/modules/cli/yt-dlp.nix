{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.yt-dlp;
in
{
  options.myHome.cli.yt-dlp = {
    enable = lib.mkEnableOption "Enable the yt-dlp media downloader.";
  };
  config = mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;
      settings = {
        embed-metadata = true;
        embed-thumbnail = true;
        embed-subs = true;
        format = "bestaudio+bestvideo[height<=1080]";
        merge-output-format = "mkv";
        sub-langs = "en,eo";
      };
    };
  };
}
