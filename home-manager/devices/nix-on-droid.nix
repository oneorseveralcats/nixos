{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    findutils
    gnugrep gnused
    ncurses
    openssh
    procps
  ];

  home.shellAliases.home-manager = "nix-on-droid";

  xdg.configFile."fish/conf.d/background-processes.fish".source = pkgs.writers.writeFish "background-processes" ''
    if status --is-interactive
      if ! pgrep ssh-agent > /dev/null
        eval (ssh-agent -c) > /dev/null

        trap "ssh-agent -k > /dev/null" SIGINT SIGTERM EXIT
      end
    end
  '';

  programs.zellij.settings.default_shell = "bash";

  myHome.testing.enable = true;
  myHome.media.mpv.enable = lib.mkForce false;
}
