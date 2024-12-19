{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.root;
in
{
  imports = [ <home-manager/nixos> ];

  options.myConfig.root = {
    enable = lib.mkOption {
      description = "Enable root home-manager/nixos config";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.root = { pkgs, ...}: {
      xdg.userDirs.enable = true;
      home.preferXdgDirectories = true;

      home.shellAliases = {
        n = "lf";
        q = "exit";
      };

      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
          theme = "base16_transparent";
          editor = {
            bufferline = "multiple";
            color-modes = true;
            mouse = false;
            lsp.display-messages = true;
            soft-wrap.enable = true;
            auto-pairs = {
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
            };
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            indent-guides = {
              render = true;
              character = "╎";
              skip-levels = 1;
            };
            statusline = {
              left = [ "mode" "spinner" "file-name" "read-only-indicator" "file-modification-indicator" ];
              center = [ "file-type" ];
              right = [ "diagnostics" "spacer" "selections" "spacer" "position-percentage" "spacer" "position" "spacer" "register" ];
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };
          };
          keys.normal = {
            Z.Z = [ ":wqa!" ];
            g.t = [ ":buffer-next" ];
            g.T = [ ":buffer-previous" ];
            X = [ "extend_line_up"  "extend_to_line_bounds" ];
          };
          keys.select = {
            X = [ "extend_line_up"  "extend_to_line_bounds" ];
          };
        };
        extraPackages = with pkgs; lib.mkDefault [
          marksman
          nil nodePackages.bash-language-server
        ];
      };      

      programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";

        autocd = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        history = {
          path = "$XDG_CONFIG_HOME/zsh/zsh_history";
          expireDuplicatesFirst = true;
          ignoreSpace = true;
        };

        completionInit = ''
          autoload -U compinit && compinit -u
          _comp_options+=(globdots)
        '';
        initExtra = ''
          # Prompt
          autoload -U colors && colors 
          PROMPT="%{$fg[red]%}%~%{$reset_color%}> "

          [ -n "$NNNLVL" ] && PROMPT="N$NNNLVL $PROMPT"
          [ -n "$LF_LEVEL" ] && PROMPT="LF$LF_LEVEL $PROMPT"
          [ -n "$CONTAINER_ID" ] && PROMPT="($CONTAINER_ID) $PROMPT"

          prompt_nix_shell_setup


          # Keybindings
          bindkey -M viins -- '^[[27;2;13~' autosuggest-execute
          bindkey -M vicmd -- '^[[27;2;13~' autosuggest-execute
          bindkey -M vicmd -- 'k' history-beginning-search-backward
          bindkey -M vicmd -- 'j' history-beginning-search-forward

          # Load After
          zvm_after_init_commands=(autopair-init)
        '';

        plugins = with pkgs; [
          { name = zsh-completions.pname; src = zsh-completions.src; }
          { name = zsh-nix-shell.pname; src = zsh-nix-shell.src; file = "nix-shell.plugin.zsh"; }
          { name = nix-zsh-completions.pname; src = nix-zsh-completions.src; }
          { name = zsh-vi-mode.pname; src = zsh-vi-mode.src; }
          { name = zsh-autopair.pname; src = zsh-autopair.src; }
        ];
      };     

      home.stateVersion = "21.11";
    };

  };
}
