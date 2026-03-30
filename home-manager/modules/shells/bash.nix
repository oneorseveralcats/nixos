{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.shells.bash;
in
{
  options.myHome.shells.bash = {
    enable = lib.mkEnableOption "Enable the Bourne-Again SHell.";
  };

  config = mkIf cfg.enable {
    myHome.shells.carapace.enable = true;

    programs.bash = {
      enable = true;
      bashrcExtra = let
        setPrompt = /* bash */ '' 
          BLUE='\e[0;34m'
          RESET='\e[m'

          PS1="''${BLUE}(bash) \w''${RESET}> "
          [ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
          [ -n "$LF_LEVEL" ] && PS1="LF$LF_LEVEL $PS1"
        '';
        waylandSessionManager = with config.myHome.desktop.compositors; pkgs.writers.writeBash "waylandSessionManager" ''
          wm=$(NEWT_COLORS='
            root=,black
            border=black,white
            title=blue,white
            textbox=black,white
            window=,white
            listbox=black,white
            actsellistbox=white,blue
            actlistbox=white,blue
            compactbutton=white,white
            button=white,white
          '\
            ${pkgs.newt}/bin/whiptail --title "Session" --menu \
              "Choose a session to run" 0 0 0 \
              ${lib.optionalString labwc.enable "'labwc' ''"}\
              ${lib.optionalString sway.enable "'sway' ''"}\
              ${lib.optionalString river.enable "'river' ''"}\
              --nocancel --default-item "sway" 3>&1 1>&2 2>&3)

          exec "''${wm}"
        '';
        # TODO: look into cleaning up command used to start shells in bash.
        shellStart = cmd: /* sh */ ''
          if ${pkgs.toybox}/bin/grep -qv "${builtins.baseNameOf cmd}" /proc/$PPID/comm && [ -z ''${BASH_EXECUTION_STRING} ]; then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${cmd} $LOGIN_OPTION
          fi
        '';
      in /* sh */ ''
        # complete -cf doas
        ${setPrompt}

        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          ${with config.myHome.desktop.compositors; lib.optionalString (builtins.any (x: x) [
            labwc.enable
            river.enable
            sway.enable
          ]) "exec ${waylandSessionManager}"}
        fi

        ${lib.optionalString config.myHome.shells.fish.enable (shellStart "${config.programs.fish.package}/bin/fish")}
      '';
    };
  };
}
