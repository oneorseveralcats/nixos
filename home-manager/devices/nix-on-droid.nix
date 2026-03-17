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

  xdg.configFile = let
    conf_d = "fish/conf.d";
  in {
    "${conf_d}/start-ssh-agent.fish".source = pkgs.writeScript "start-ssh-agent" ''
      #!/usr/bin/env fish
      if status --is-interactive && ! pgrep ssh-agent > /dev/null
        eval (ssh-agent -c) > /dev/null
      end
    '';
    "${conf_d}/kill-the-children.fish".source = pkgs.writeScript "kill-the-children" ''
      #!/usr/bin/env fish
      trap "trap - SIGTERM && kill -- -$fish_pid" SIGINT SIGTERM EXIT
    '';
  };

  programs.zellij.settings.default_shell = "bash";

  myHome.testing.enable = true;
  myHome.media.mpv.enable = lib.mkForce false;
}
