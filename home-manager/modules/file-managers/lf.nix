{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.lf;
in
{
  options.myHome.file-managers.lf = {
    enable = lib.mkEnableOption "Enable the lf file manager.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      moreutils
    ];

    myHome.file-managers.pistol.enable = true;
    myHome.cli.tmux.enable = true;
    
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
        "gm" = "cd /run/media/user/";
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
        "<tab>" = "% tmux next-window";
        "<c-t>" = "% tmux new-window -- lf $PWD";
        "Q" = "detach";
        "<c-q>" = "ask_on_quit";
        "<c-w>" = "quit";
        "<c-1>" = "% tmux select-window -t:1";
        "<c-2>" = "% tmux select-window -t:2";
        "<c-3>" = "% tmux select-window -t:3";
        "<c-4>" = "% tmux select-window -t:4";
        "<c-5>" = "% tmux select-window -t:5";
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
        cmd ask_on_quit %{{
          printf ' close all lf tabs? (y/N) '
          read -n 1 ans

          if [ $ans = "y" ] || [ $ans = "Y" ]; then
            tmux kill-session
          fi
        }}

        cmd detach % tmux detach-client
      '';
    };


    # currently using zellij for lf breaks when there are image previews
    home.file.".config/zellij/layouts/lf.kdl".text = ''
      layout name="lf" {
      	default_tab_template {
      		pane name="tab-bar" size=1 borderless=true {
      	        plugin location="zellij:compact-bar"
    	    }
      		pane command="lf"
      	}
      }
    '';
  };
}
