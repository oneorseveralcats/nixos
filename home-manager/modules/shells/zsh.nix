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
        ignoreSpace = true;
      };
      shellAliases = {
        zr = "source ${config.xdg.configHome}/zsh/.zshrc";
      };

      completionInit = ''
        autoload -U compinit && compinit -u
        _comp_options+=(globdots)
      '';
      initExtraFirst = ''
        zmodload zsh/zprof
      '';
      initExtra = ''
        # Prompt
        autoload -U colors && colors 

        PROMPT="%{$fg[blue]%}%~%{$reset_color%}> "

        [ -n "$NNNLVL" ] && PROMPT="N$NNNLVL $PROMPT"
        [ -n "$LF_LEVEL" ] && PROMPT="LF$LF_LEVEL $PROMPT"
        [ -n "$CONTAINER_ID" ] && PROMPT="($CONTAINER_ID) $PROMPT"

        RPROMPT='$GITSTATUS_PROMPT'

        prompt_nix_shell_setup
        # Keycodes
        typeset -g -A key

        
        # shift+enter auto executes completion
        # TODO: see if i can do this via terminfo instead of ugly escape sequences
        bindkey -M viins -- '^[[27;2;13~' autosuggest-execute
        bindkey -M vicmd -- '^[[27;2;13~' autosuggest-execute

        bindkey -M vicmd -- 'k' history-beginning-search-backward
        bindkey -M vicmd -- 'j' history-beginning-search-forward


        zvm_after_init_commands=(autopair-init)
      '';
      envExtra = ''
        skip_global_compinit=1
      '';

      plugins = with pkgs; [
        { name = gitstatus.pname; src = gitstatus.src; file="gitstatus.prompt.zsh"; }
        { name = zsh-autopair.pname; src = zsh-autopair.src; }
        { name = zsh-completions.pname; src = zsh-completions.src; }
        { name = zsh-nix-shell.pname; src = zsh-nix-shell.src; file = "nix-shell.plugin.zsh"; }
        { name = nix-zsh-completions.pname; src = nix-zsh-completions.src; }
        { name = zsh-vi-mode.pname; src = zsh-vi-mode.src; }
      ];
    };
  };
}
