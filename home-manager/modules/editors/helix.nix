{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.editors.helix;
in
{
  options.myHome.editors.helix = {
    enable = lib.mkEnableOption "Enable the helix text editor (hx).";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      package = pkgs.unstable.helix;
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
      languages = {
        # language-server.fennel-ls = with pkgs; {
        #   command = "${fennel-ls}/bin/fennel-ls";
        # };
        # language = [{
        #   name = "fennel";
        #   auto-format = false;
        #   comment-tokens = [ ";;" ];
        #   file-types = [ "fnl" ];
        #   language-servers = [ "fennel-ls" ];
        # }];
        
        # TODO: add spellcheck
        # language = [{
        #   name = "markdown";
        # }];
      };
      extraPackages = with pkgs; lib.mkDefault [
        unstable.awk-language-server
        marksman
        nil nodePackages.bash-language-server
        yaml-language-server
      ];
    };
  };
}
