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

  home.file.".termux/termux.properties".text = lib.generators.toKeyValue {} {
    fullscreen = true;
    # use-fullscreen-workaround = true;
  };

  programs.fish.shellInitLast = /* fish */ ''
    function autostart
      if status --is-login
        if test -n $SSH_AUTH_PID
          eval (ssh-agent -c) > /dev/null
        end
      end
    end

    function cleanup --on-event fish_exit
      if status --is-login
        ssh-agent -k > /dev/null
      end
    end

    autostart
  '';

  programs.zellij.settings.default_shell = "bash";

  myHome.testing.enable = true;
  myHome.media.mpv.enable = lib.mkForce false;
}
