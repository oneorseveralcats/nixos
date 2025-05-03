{...}:
{
  myHome = {
    browsers.w3m.enable = true;

    cli = {
      aria2.enable = true;
      bat.enable = true;
      htop.enable = true;
      hyfetch.enable = true;
      pandoc.enable = true;
      nb.enable = true;
      readline.enable = true;
      sc-im.enable = true;
      yt-dlp.enable = true;
      zellij.enable = true;
    };

    editors = {
      helix.enable = true;
    };

    file-managers = {
      lf.enable = true;
    };

    media = {
      mpv.enable = true;
      ncmpcpp.enable = true;
      newsboat.enable = true;
    };

    math.enable = true;
    mime.enable = true;

    shells = {
      bash.enable = true;      
      fish.enable = true;
    };

    socials = {
      weechat.enable = true;
    };
  };
}
