{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.bash;
in
{
  options.myHome.shells.bash = {
    enable = lib.mkOption {
      description = "Enable the Bourne-Again SHell.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        complete -cf doas
        [ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
        [ -n "$LF_LEVEL" ] && PS1="LF$LF_LEVEL $PS1"

        gd () {
          if [ -z "$@" ]; then
            cd "$(lf -print-last-dir)"
          else
            cd "$@"
          fi
        }

        # auto launches sway on tty1
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec ${pkgs.sway}/bin/sway
        fi
      '';
    };
  };
}
