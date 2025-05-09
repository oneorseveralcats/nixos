
{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.tmux;
in
{
  options.myHome.cli.tmux = {
    enable = lib.mkEnableOption "Enable the tmux terminal multiplexer.";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      tmuxp.enable = true;
      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = true;
      keyMode = "vi";
      newSession = true;
      # sensibleOnTop = false;
      terminal = "screen-256color";
      extraConfig = ''
        bind '|' splitw -h
        bind '_' splitw -v
        bind C-f resize-pane -Z
        bind 'h' select-pane -L
        bind 't' select-pane -U
        bind 'n' select-pane -D
        bind 's' select-pane -R

        set -s escape-time 0

        set -g status-position top
        set -g status-style fg=#${config.lib.stylix.colors.base05-hex},bg=#${config.lib.stylix.colors.base00-hex}
        set -g window-status-style fg=#${config.lib.stylix.colors.base05-hex},bg=#${config.lib.stylix.colors.base00-hex}
        set -g window-status-current-style fg=#${config.lib.stylix.colors.base00-hex},bg=#${config.lib.stylix.colors.base0D-hex}

        # I can't figure out how to get this to work or why it doesn't. If I ever use tmux for anything other than lf, it's probably important to figure that out
        %if "#{==:#{session_name},lf}"
          set -g window-status-format "#I"
          set -g window-status-current-format "#I"
          set -g status-left " "
          set -g status-right ""
        %endif

        set -g window-status-format "#I"
        set -g window-status-current-format "#I"
        set -g status-left " "
        set -g status-right ""
      '';
    };

    home.file.".config/tmuxp/default.yml" = {
      text = ''
        session_name: default
        windows:
          - panes:
            - shell: "${pkgs.ncmpcpp}/bin/ncmpcpp"
          - panes:
            - newsboat
          - window_name: pulsemixer
            panes:
            - shell: "${pkgs.pulsemixer}/bin/pulsemixer"
          - window_index: 9
            panes:
            - shell_command: 
              - cd ~/projects/programming/rssfeed_hackery
              - while true; do ./run.sh; sleep 1h; done
      '';
    };
  };
}
