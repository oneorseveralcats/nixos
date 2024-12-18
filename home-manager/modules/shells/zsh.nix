{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.zsh;
in
{
  options.myHome.shells.zsh = {
    enable = lib.mkOption {
      description = "Enable the Z shell.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";

      autocd = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        path = "${config.xdg.configHome}/zsh/zsh_history";
        expireDuplicatesFirst = true;
      };
      shellAliases = {
        zr = "source ${config.xdg.configHome}/zsh/.zshrc";
      };

      initExtraFirst = ''
        zmodload zsh/zprof
      '';
      initExtra = ''
        autoload -U colors && colors 

        if [ -n "$IN_NIX_SHELL" ]; then
          PROMPT="%{$fg[green]%}%~%{$reset_color%}> "
        else 
          case "$(whoami)" in
            root) 
              PROMPT="%{$fg[red]%}%~%{$reset_color%}> ";;
            *) 
              PROMPT="%{$fg[blue]%}%~%{$reset_color%}> ";;
          esac
        fi

        setopt promptsubst
        RPROMPT="\$(${pkgs.gitprompt-rs}/bin/gitprompt-rs zsh)"
      '';

      plugins = with pkgs; [
        { name = zsh-autopair.pname; src = zsh-autopair.src; }
        { name = zsh-completions.pname; src = zsh-completions.src; }
        { name = zsh-forgit.pname; src = zsh-forgit.src; file = "forgit.plugin.zsh"; }
        { name = zsh-nix-shell.pname; src = zsh-nix-shell.src; file = "nix-shell.plugin.zsh"; }
        { name = zsh-vi-mode.pname; src = zsh-vi-mode.src; }
      ];
    };
  };
}
