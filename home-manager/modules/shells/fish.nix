
{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.fish;
in
{
  options.myHome.shells.fish = {
    enable = lib.mkEnableOption "Enable the fish.";
  };

  config = mkIf cfg.enable {
    myHome.shells.carapace.enable = true;

    home.packages = with pkgs; [
      grc
    ];

    # programs.foot.settings.main.shell = "fish";
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting

        function fish_title; end

        # Prompt
        # ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

        function fish_prompt
          if test -n "$LF_LEVEL"
            set LF "LF$LF_LEVEL "
          end
          if test -n "$NNNLVL"
            set NNN "N$NNNLVL "
          end

          if test -n "$CONTAINER_ID"
            set CONTAINER "($CONTAINER_ID) "
          end

          string join "" -- (printf '%s' $CONTAINER) \
                            (printf '%s' $LF)        \
                            (printf '%s' $NNN)       \
                            (set_color blue) (prompt_pwd --full-length-dirs 2) (set_color normal) '> '
        end

        if not set -q __fish_git_prompt_show_informative_status
          set -g __fish_git_prompt_show_informative_status 1
        end
        if not set -q __fish_git_prompt_hide_untrackedfiles
            set -g __fish_git_prompt_hide_untrackedfiles 1
        end
        if not set -q __fish_git_prompt_color_branch
            set -g __fish_git_prompt_color_branch magenta --bold
        end
        if not set -q __fish_git_prompt_showupstream
            set -g __fish_git_prompt_showupstream informative
        end
        if not set -q __fish_git_prompt_color_dirtystate
            set -g __fish_git_prompt_color_dirtystate blue
        end
        if not set -q __fish_git_prompt_color_stagedstate
            set -g __fish_git_prompt_color_stagedstate yellow
        end
        if not set -q __fish_git_prompt_color_invalidstate
            set -g __fish_git_prompt_color_invalidstate red
        end
        if not set -q __fish_git_prompt_color_untrackedfiles
            set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
        end
        if not set -q __fish_git_prompt_color_cleanstate
            set -g __fish_git_prompt_color_cleanstate green --bold
        end

        function fish_right_prompt
          fish_vcs_prompt
        end

        function fish_mode_prompt; end

        # Keybindings
        function fish_user_key_bindings
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert

          bind -M default \ce accept-autosuggestion execute
          bind -M insert \ce accept-autosuggestion execute
        end

        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore
        set fish_cursor_external line
        set fish_cursor_visual block
      '';
      plugins = with pkgs.fishPlugins; [
        {
          name = autopair.pname;
          src = autopair.src;
        }
        {
          name = foreign-env.pname;
          src = foreign-env.src;
        }
        {
          name = grc.pname;
          src = grc.src;
        }
        # {
        #   name = hydro.pname;
        #   src = hydro.src;
        # }
      ];
    };
  };
}
