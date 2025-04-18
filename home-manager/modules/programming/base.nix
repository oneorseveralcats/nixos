{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming.base;
in
{
  options.myHome.programming.base = {
    enable = lib.mkOption {
      description = "Enable basic programming tools.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.shellAliases = {
      lg = "${pkgs.lazygit}/bin/lazygit";
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.git = {
      enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        user = {
          email = "oosc@noreply.codeberg.org";
          name = "oneorseveralcats";
          signingkey = "~/.ssh/oosc.pub";
        };
        gpg = {
          format = "ssh";
        };
        commit = {
          gpgSign = true;
        };
      };
    };

    programs.lazygit = {
      enable = true;
    };

    services.ssh-agent.enable = true;
  };
}



