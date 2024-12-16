
{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.multiplexers.tmux;
in
{
  options.myHome.multiplexers.tmux = {
    enable = lib.mkOption {
      description = "Enable the tmux terminal multiplexer.";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      tmuxp.enable = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      extraConfig = ''
        bind '|' splitw -h
        bind '_' splitw -v
        unbind '"'
        unbind '%'
        bind C-f resize-pane -Z
        bind 'h' select-pane -L
        bind 't' select-pane -U
        bind 'n' select-pane -D
        bind 's' select-pane -R
        bind 'Tab' choose-tree -Zs
        set  -g status-style bg=black,fg=white
        setw -g window-status-current-style fg=black,bg=white
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
