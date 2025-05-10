{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.joshuto;
in
{
  options.myHome.file-managers.joshuto = {
    enable = lib.mkEnableOption "Enable the joshuto file manager.";
  };

  config = mkIf cfg.enable {
    myHome.file-managers.pistol.enable = true;

    programs.joshuto = {
      enable = true;
      settings = {
        xdg_open = true;
        xdg_open_fork = true;

      
        display = {
        };

        preview = {
          preview_protocol = "sixel";
          max_preview_size = "10GB";
          preview_script = "${config.xdg.configHome}/joshuto/preview";
        };
      };
      keymap = {};
    };


    xdg.configFile."joshuto/preview" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        
        IFS=$'\n'

        # set -o noclobber -o noglob -o nounset -o pipefail

        # FILE_PATH=""
        # PREVIEW_WIDTH=10
        # PREVIEW_HEIGHT=10

        while [ "$#" -gt 0 ]; do
            case "$1" in
            "--path")
                shift
                FILE_PATH="$1"
                ;;
            "--preview-width")
                shift
                PREVIEW_WIDTH="$1"
                ;;
            "--preview-height")
                shift
                PREVIEW_HEIGHT="$1"
                ;;
            esac
            shift
        done

        # image previews currently don't work because joshuto doesn't support sixel. unlikely to use until it does
        ${pkgs.pistol}/bin/pistol "$FILE_PATH" "$PREVIEW_WIDTH" "$PREVIEW_HEIGHT" && exit 0
      '';
    };
  };
}



