{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.rtorrent;
in
{
  options.myHome.cli.rtorrent = {
    enable = lib.mkEnableOption "the rtorrent tui torrenting client.";
  };

  config = mkIf cfg.enable {
    # NOTE: doesn't currently download torrents
    programs.rtorrent = {
      enable = true;
      extraConfig = ''
        ## Peer settings
        throttle.max_uploads.set = 100
        throttle.max_uploads.global.set = 250

        throttle.min_peers.normal.set = 20
        throttle.max_peers.normal.set = 60
        throttle.min_peers.seed.set = 30
        throttle.max_peers.seed.set = 80
        trackers.numwant.set = 80

        dht.mode.set = auto
        protocol.pex.set= yes

        # check hashes
        pieces.hash.on_completion.set = yes

        directory.default.set = ${config.xdg.userDirs.download}
        session.path.set = ${config.xdg.dataHome}/rtorrent/session

        protocol.encryption.set = allow_incoming,try_outgoing,enable_retry

        schedule2 = watch_directory,5,5,load.start=${config.xdg.userDirs.download}/torrents
      '';
    };
  };
}
