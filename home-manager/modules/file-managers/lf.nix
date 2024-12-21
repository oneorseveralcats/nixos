{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.lf;
in
{
  options.myHome.file-managers.lf = {
    enable = lib.mkOption {
      description = "Enable the lf file manager.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    myHome.file-managers.pistol.enable = true;
    
    home.file.".config/lf/colors".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example";
    home.file.".config/lf/icons".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";

    programs.lf = {
      enable = true;
      previewer = {
        source = "${pkgs.pistol}/bin/pistol";
      };
      settings = {
        drawbox = true;
        ifs = "\n";
        incfilter = true;
        incsearch = true;
        promptfmt = "\\033[34;1m%d\\033[0m\\033[1m%f\\033[0m";
        sixel = true;
      };
      keybindings = {
        "." = "set hidden!";
        "DD" = "delete";
        "gd" = "cd ~/downloads";
        "gD" = "cd ~/documents";
        "ge" = "bottom";
        "gh" = "cd ~";
        "gp" = "cd ~/pictures";
        "gr" = "cd /media/removable";
        "gs" = "cd /media/storage";
        "gS" = "cd ~/documents/school";
        "gv" = "cd ~/videos/";
        "g/" = "cd /";

        "<c-f>" = "filter";

        "af" = "touch";
        "ad" = "mkdir";
        "ac" = "chmod";
        "ax" = "extract";

        "xd" = ''& ${pkgs.ripdrag}/bin/ripdrag -A -x -n -r $fx'';
        "xr" = ''''${{ [ -n "$fs" ] && vidir $fs || vidir $PWD }}'';
        "xm" = ''$mpv $fx'';
        "xw" = ''$pandoc -t html "$f" | w3m -T text/html'';
      };
      extraConfig = ''
        cmd mkdir %{{
          printf ' directory name: '
          read ans
          mkdir -p -- "$ans"
        }}
        cmd touch %{{
          printf ' file name: '
          read ans
          touch -- "$ans"
        }}
        cmd chmod %{{
          IFS='\n'
          printf ' chmod: '
          read ans
          chmod $ans $fx
          lf -remote "send $id reload"
        }}
        cmd extract $ IFS='\n' atool -x $fx
      '';
    };
  };
}
