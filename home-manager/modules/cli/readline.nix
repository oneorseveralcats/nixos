{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.cli.readline;
in
{
  options.myHome.cli.readline = {
    enable = lib.mkEnableOption "Enable the readline commandline interface configuration.";
  };

  config = mkIf cfg.enable {
    programs.readline = {
      enable = true;
      includeSystemConfig = true;
      bindings = {
        "\\C-l" = "clear-screen";
      };
      extraConfig = ''
        set editing-mode vi
        set show-mode-in-prompt on
        set vi-ins-mode-string \1\e[6 q\2
        set vi-cmd-mode-string \1\e[2 q\2
        set editing-mode vi
        $if mode=vi
        set keymap vi-command
        # these are for vi-command mode
        "\e[A": history-search-backward
        "\e[B": history-search-forward
        j: history-search-forward
        k: history-search-backward
        set keymap vi-insert
        # these are for vi-insert mode
        "\e[A": history-search-backward
        "\e[B": history-search-forward
        $endif
      '';
    };
  };
}

