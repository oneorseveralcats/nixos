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
      tmux
    ];

    myHome.file-managers.pistol.enable = true;
    # myHome.cli.tmux.enable = true;
    
    xdg.configFile."lf/colors".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/colors.example";
    xdg.configFile."lf/icons".source = builtins.fetchurl "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";

    home.shellAliases = {
      "lft" = "tmux -L lf -f .config/lf/tmux.conf new-session -A -s lf -- lf";
    };

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

        "e" = "editor";

        "<c-f>" = "filter";

        "af" = "touch";
        "ad" = "mkdir";
        "ac" = "chmod";

        "xd" = ''& ${pkgs.ripdrag}/bin/ripdrag -A -x -n -r $fx'';
        "xm" = ''$ ${pkgs.mpv}/bin/mpv $fx'';
        "xr" = ''''${{ [ -n "$fs" ] && ${pkgs.moreutils}/bin/vidir $fs || ${pkgs.moreutils}/bin/vidir $PWD }}'';
        "xw" = ''$ ${pkgs.pandoc}/bin/pandoc -t html "$f" | ${pkgs.w3m}/bin/w3m -T text/html'';
        "xx" = ''extract'';

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
        "<c-6>" = "% tmux select-window -t:6";
        "<c-7>" = "% tmux select-window -t:7";
        "<c-8>" = "% tmux select-window -t:8";
        "<c-9>" = "% tmux select-window -t:9";
        "<c-0>" = "% tmux select-window -t:0";
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
          chmod $ans $f
          lf -remote "send $id reload"
        }}

        cmd extract %{{
          if ! (${pkgs.atool}/bin/atool -x -- "$f"); then
            printf ' format not recognized. manually specify: '
            read ans
            if ! (${pkgs.atool}/bin/atool -F $ans -x "$f"); then
              printf ' error: unable to extract. try again.'
            fi
          fi
        }}

        cmd editor $ IFS="\n" $EDITOR "$@" $fx

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

    xdg.configFile."lf/tmux.conf".text = ''
      set -g base-index 1

      set -s escape-time 0

      set -g default-terminal "screen-256color"

      set -g status-position top
      set -g status-style fg=#${config.lib.stylix.colors.base05-hex},bg=#${config.lib.stylix.colors.base00-hex}
      set -g window-status-style fg=#${config.lib.stylix.colors.base05-hex},bg=#${config.lib.stylix.colors.base00-hex}
      set -g window-status-current-style fg=#${config.lib.stylix.colors.base00-hex},bg=#${config.lib.stylix.colors.base0D-hex}

      set -g window-status-format "#I"
      set -g window-status-current-format "#I"
      set -g status-left " "
      set -g status-right ""
    '';

    # currently using zellij for lf breaks when there are image previews
    xdg.configFile."zellij/layouts/lf.kdl".text = ''
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
