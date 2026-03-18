{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    findutils
    gnugrep gnused
    killall
    ncurses
    openssh
    procps
  ];

  home.shellAliases.home-manager = "nix-on-droid";

  programs.fish.shellInitLast = /* fish */ ''
    function autostart
      if status is-login
        if test -n $SSH_AUTH_PID
          eval (ssh-agent -c) > /dev/null
        end
      end
    end

    function cleanup --on-event fish_exit
      if status is-login || test $SHLVL -eq 2 && test -n "$ZELLIJ"
        ssh-agent -k > /dev/null
      end
    end

    autostart

    set ZELLIJ_AUTO_EXIT true
    if status is-interactive
      eval (zellij setup --generate-auto-start fish | string collect)
    end
  '';

  programs.zellij.settings.default_shell = "bash";

  myHome.testing.enable = true;
  myHome.media.mpv.enable = lib.mkForce false;
}
