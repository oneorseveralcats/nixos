{ pkgs, lib, ... }:
{
  imports = [
    ../home.nix
  ];

  home.packages = with pkgs; [
    findutils
    gawk gnugrep gnused
    killall
    ncurses
    openssh
    procps
  ];

  home.sessionVariables.SHELL = "${pkgs.bash}/bin/bash";
  home.shellAliases.home-manager = "nix-on-droid";

  programs.nom.settings.openers = lib.mkForce [
    { regex = "youtube"; cmd = "termux-open --content-type video %s"; }
  ];

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
  myHome = {
    # giac-with-xcas is ~1gb in size
    math.enable = lib.mkForce false;

    stylix.styleDesktopApps = false;

    media = {
      mpv.enable = lib.mkForce false;
      ncmpcpp.enable = lib.mkForce false;
      nom.enable = lib.mkForce false;
    };
  };
}
