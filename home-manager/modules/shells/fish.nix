
{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.fish;
in
{
  options.myHome.shells.fish = {
    enable = lib.mkOption {
      description = "Enable the fish.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grc
    ];

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting

        # Prompt
        function fish_prompt
            string join "" -- (set_color blue) (prompt_pwd --full-length-dirs 2) (set_color normal) '> '
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

          bind -M default \co accept-autosuggestion execute
          bind -M insert \co accept-autosuggestion execute
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
