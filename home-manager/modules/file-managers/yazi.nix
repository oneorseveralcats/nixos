{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.file-managers.yazi;
in
{
  options.myHome.file-managers.yazi = {
    enable = lib.mkEnableOption "Enable the yazi file manager.";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      shellWrapperName = "f";
      keymap = {
        mgr.prepend_keymap = [
          { desc = "Go documents"; on = [ "g" "D" ]; run = "cd ${config.xdg.userDirs.documents}"; }
          { desc = "Go downloads"; on = [ "g" "d" ]; run = "cd ${config.xdg.userDirs.download}"; }
          { desc = "Go pictures"; on = [ "g" "P" ]; run = "cd ${config.xdg.userDirs.pictures}"; }
          { desc = "Go projects"; on = [ "g" "p" ]; run = "cd ${config.xdg.userDirs.projects}"; }
          { desc = "Go projects"; on = [ "g" "v" ]; run = "cd ${config.xdg.userDirs.videos}"; }

          { desc = "Go automount"; on = [ "g" "m" ]; run = "cd /run/media/user/"; }
          { desc = "Go nixos config"; on = [ "g" "N" ]; run = "cd ~/git/nixos"; }
          { desc = "Go nas"; on = [ "g" "n" ]; run = "cd /media/nas/"; }
          { desc = "Go root"; on = [ "g" "/" ]; run = "cd /"; }

          { desc = "Go to bot"; on = [ "g" "e" ]; run = "arrow bot"; }

          { desc = "$EDITOR"; on = [ "e" ]; run = "shell --block -- IFS='\n' $EDITOR %s"; }
          { desc = "$SHELL"; on = [ "!" ]; run = ''shell "\$SHELL" --block''; }

          { desc = "Next tab"; on = [ "t" "n" ]; run = "tab_switch --relative 1"; }
          { desc = "Prev tab"; on = [ "t" "p" ]; run = "tab_switch --relative -1"; }
          { desc = "Close tab"; on = [ "q" ]; run = "close"; }

          { desc = "enter directory, or open file"; on = "l"; run = "plugin smart-enter"; }
          { desc = "enter directory, or open file"; on = "<right>"; run = "plugin smart-enter"; }

          { desc = "Run a shell command"; on = [ ";" ";" ]; run = "shell --interactive"; }
          { desc = "ripdrag"; on = [ ";" "d" ]; run = "shell -- ${lib.getExe pkgs.ripdrag} -A -x -n -r %s"; }
        ];
      };
      settings = {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
          sort_sensitive = false;
          sort_translit = true;
        };
        plugin = {
          prepend_preloaders = [
            # currently broke
            # Office Documents
            # { mime = "application/openxmlformats-officedocument.*"; run = "office"; }
            # { mime = "application/oasis.opendocument.*"; run = "office"; }
            # { mime = "application/ms-*"; run = "office"; }
            # { mime = "application/msword"; run = "office"; }
          ];

          prepend_previewers = [
            # Archives
            { mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}"; run  = "ouch"; }

            # currently broke
            # Office Documents
            # { mime = "application/openxmlformats-officedocument.*"; run = "office"; }
            # { mime = "application/oasis.opendocument.*"; run = "office"; }
            # { mime = "application/ms-*"; run = "office"; }
            # { mime = "application/msword"; run = "office"; }
          ];
          # append_previews = [
          #   { name = "*"; run = "${pkgs.pistol}/bin/pistol"; }
          # ];
        };
      };
      plugins = with pkgs.yaziPlugins; {
        full-border = {
          package = full-border;
          setup = true;
          settings = {
            type = lib.generators.mkLuaInline "ui.Border.PLAIN";
          };
        };

        office = office;
        ouch = ouch;
        smart-enter = smart-enter;

        # currently unused
        smart-filter = smart-filter;
        rich-preview = rich-preview;
        piper = piper;
      };
      initLua = /* lua */ ''
        ps.sub("ind-app-title", function(args)
          args.value = "Terminal"
          return args
        end)
      '';
      extraPackages = with pkgs; [
        ouch
        # rich-cli # rich-preview
        # libreoffice poppler-utils # office plugin currently broke
      ];
    };
  };
}
