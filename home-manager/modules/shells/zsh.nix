{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.zsh;
in
{
  options.myHome.shells.zsh = {
    enable = lib.mkEnableOption "Enable the Z shell.";
  };

  config = mkIf cfg.enable {
    myHome.shells.carapace.enable = true;

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

        # RPROMPT='$GITSTATUS_PROMPT'

        RPROMPT='$(gitprompt)'

        prompt_nix_shell_setup

        
        # Keycodes
        typeset -g -A key

        
        # shift+enter auto executes completion
        # TODO: see if i can do this via terminfo instead of ugly escape sequences
        bindkey -M viins -- '^o' autosuggest-execute
        bindkey -M vicmd -- '^o' autosuggest-execute

        bindkey -M vicmd -- 'k' history-beginning-search-backward
        bindkey -M vicmd -- 'j' history-beginning-search-forward


        zvm_after_init_commands=(autopair-init)
      '';
      envExtra = ''
        skip_global_compinit=1

        setopt no_global_rcs
      '';

      plugins = with pkgs; [
        { name = gitstatus.pname; src = gitstatus.src; file="gitstatus.prompt.zsh"; }
        { name = zsh-autopair.pname; src = zsh-autopair.src; }
        { name = zsh-completions.pname; src = zsh-completions.src; }
        { name = zsh-nix-shell.pname; src = zsh-nix-shell.src; file = "nix-shell.plugin.zsh"; }
        { name = nix-zsh-completions.pname; src = nix-zsh-completions.src; }
        { name = zsh-vi-mode.pname; src = zsh-vi-mode.src; }

        {
          name = "git-prompt.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "woefe";
            repo = "git-prompt.zsh";
            rev = "0193adeb09fbc51fac738081a4718a3cf8427ff8";
            hash = "sha256-Q7Dp6Xgt5gvkWZL+htDmGYk9RTglOWrrbl6Wf6q/qjY=";
          };
          file = "git-prompt.plugin.zsh";
        }
      ];
    };
  };
}
