{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.mpd;
in
{
  options.myHome.media.mpd = {
    enable = lib.mkEnableOption "Enable the music player daemon (mpd).";
  };

  config = mkIf cfg.enable {
    services.playerctld.enable = true;
    services.mpd-mpris.enable = true;

    services.mpd = {
      enable = true;
      musicDirectory = "~/audio/music";
      extraConfig = ''
        audio_output {
          type            "pulse"
          name            "pulse"
        }
        # mpd volume changes when other inputs change it
        # see: https://github.com/MusicPlayerDaemon/MPD/issues/1588
        # audio_output {
        #   type            "pipewire"
        #   name            "PipeWire Sound Server"
        # }
      '';
    };
  };
}
