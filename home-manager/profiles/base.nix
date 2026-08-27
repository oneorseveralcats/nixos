{...}:
{
  myHome = {
    base.enable = true;
    bluetooth.enable = true;
    games.cli.enable = true;
    programming.base.enable = true;
    stylix.enable = true;
    virtualization.distrobox.enable = true;

    browsers = {
      chawan.enable = true;
      w3m.enable = true;
    };

    cli = {
      aria2.enable = true;
      asciinema.enable = true;
      atool.enable = true;
      bat.enable = true;
      htop.enable = true;
      hyfetch.enable = true;
      pandoc.enable = true;
      nb.enable = true;
      readline.enable = true;
      ripgrep.enable = true;
      sc-im.enable = true;
      yt-dlp.enable = true;
      zellij.enable = true;
    };

    editors = {
      helix.enable = true;
    };

    file-managers = {
      yazi.enable = true;
    };

    media = {
      mpv.enable = true;
      ncmpcpp.enable = true;
      nom.enable = true;
    };

    math.enable = true;
    mime.enable = true;

    shells = {
      bash.enable = true;      
      fish.enable = true;
    };
  };
}
