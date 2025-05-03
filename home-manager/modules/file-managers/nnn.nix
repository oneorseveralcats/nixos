{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.nnn;
in
{
  options.myHome.file-managers.nnn = {
    enable = lib.mkEnableOption "Enable the nnn file manager.";
  };

  config = mkIf cfg.enable {
    programs.nnn = {
      enable = true;
      bookmarks = {
        D = "~/documents";
        d = "~/downloads";
        h = "~/";
        p = "~/pictures";
        r = "/media/removable";
        S = "~/documents/school";
        s = "/media/storage";
        v = "~/videos";
      };
      plugins = {
        src = (pkgs.fetchFromGitHub {
            owner = "jarun";
            repo = "nnn";
            rev = "v4.0";
            sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
        }) + "/plugins";
        mappings = {
          d = "dragdrop";
          m = ''!mpv \"\$nnn\"*'';
        };
      };
    };
  };
}
