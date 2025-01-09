{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.newsboat;
in
{
  options.myHome.media.newsboat = {
    enable = lib.mkOption {
      description = "Enable the newsboat feedreader.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.newsboat = {
      enable = true;
      autoReload = true;
      browser = ''"mpvc -q -a"'';
      extraConfig = ''
        bind-key j next
        bind-key k prev
        bind-key J next-feed
        bind-key K prev-feed

        macro y set browser "echo -n %u | wl-copy" ; open-in-browser ; set browser ${config.programs.newsboat.browser}

        #     #element           #fg    #bg    #attr
        color listfocus          black  white
        color listfocus_unread   black  white  bold
        color info               black  white  bold
        color end-of-text-marker black  black  invis
      '';
      queries = {
        #foo = ''author =~ "BadEmpanada"'';
      };
      urls = [
        { tags = [ "~Youtube" ]; url = "file:///home/user/sync/default/youtube.rss"; }
        # { tags = [ "~Podcasts" ]; url = "file:///media/storage/projects/programming/rssfeed_hackery/podcasts.rss"; }
        { tags = [ "~StandardEbooks Releases" ]; url = "https://standardebooks.org/rss/new-releases"; }
      ];
    };
  };
}
