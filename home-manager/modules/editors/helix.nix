{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.helix;
  unstable = import <nixos-unstable> {};
in
{
  options.myHome.editors.helix = {
    enable = lib.mkOption {
      description = "Enable the helix text editor (hx).";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      package = unstable.helix;
      defaultEditor = true;
      settings = {
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
        yaml-language-server
      ];
    };
  };
}
