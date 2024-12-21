{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myConfig.root;
in
{
  imports = [ <home-manager/nixos> ];

  options.myConfig.root = {
    enable = lib.mkOption {
      description = "Enable root home-manager/nixos config";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.backupFileExtension = "backup";
    home-manager.users.root = { pkgs, ...}: {
      xdg.userDirs.enable = true;
      home.preferXdgDirectories = true;

      home.shellAliases = {
        n = "lf";
        q = "exit";
      };

      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
          theme = "base16_transparent";
          editor = {
            bufferline = "multiple";
            color-modes = true;
            mouse = false;
            lsp.display-messages = true;
            soft-wrap.enable = true;
            auto-pairs = {
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
            };
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            indent-guides = {
              render = true;
              character = "╎";
              skip-levels = 1;
            };
            statusline = {
              left = [ "mode" "spinner" "file-name" "read-only-indicator" "file-modification-indicator" ];
              center = [ "file-type" ];
              right = [ "diagnostics" "spacer" "selections" "spacer" "position-percentage" "spacer" "position" "spacer" "register" ];
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };
          };
          keys.normal = {
            Z.Z = [ ":wqa!" ];
            g.t = [ ":buffer-next" ];
            g.T = [ ":buffer-previous" ];
            X = [ "extend_line_up"  "extend_to_line_bounds" ];
          };
          keys.select = {
            X = [ "extend_line_up"  "extend_to_line_bounds" ];
          };
        };
        extraPackages = with pkgs; lib.mkDefault [
          marksman
          nil nodePackages.bash-language-server
        ];
      };      

      home.stateVersion = "21.11";
    };

  };
}
