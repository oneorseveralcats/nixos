
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

        set -g __fish_git_prompt_show_informative_status 1
        set -g __fish_git_prompt_hide_untrackedfiles 1
        set -g __fish_git_prompt_color_branch magenta --bold
        set -g __fish_git_prompt_showupstream informative
        set -g __fish_git_prompt_color_dirtystate blue
        set -g __fish_git_prompt_color_stagedstate yellow
        set -g __fish_git_prompt_color_invalidstate red
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
        set -g __fish_git_prompt_color_cleanstate green --bold

        function fish_right_prompt
          fish_vcs_prompt
        end

        function fish_mode_prompt; end

        # Keybindings
        function fish_user_key_bindings
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase

          bind -M default \ce accept-autosuggestion execute
          bind -M insert \ce accept-autosuggestion execute
        end

        # required for autopair to work????
        set -g fish_key_bindings fish_user_key_bindings


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
