{ config, lib, pkgs, ... }:
with lib;
let 
  inherit (lib)
    optional
    optionals;
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
      defaultEditor = lib.mkDefault true;
      settings = {
        theme = lib.mkForce "stylix-custom";
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
          rulers = [ 81 101 121 ];
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
        keys.insert = {
          "A-space" = "normal_mode";
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
        # TODO: add spellcheck
        # language = [{
        #   name = "markdown";
        # }];
      };
      extraPackages = let
        lang = config.myHome.programming.languages;
      in with pkgs; [
        awk-language-server
        marksman
        nixd nodePackages.bash-language-server
        yaml-language-server
      ]
        ++ optional lang.clojure.enable pkgs.clojure-lsp
        ++ optional lang.crystal.enable pkgs.crystalline
        ++ optional lang.d.enable pkgs.serve-d
        ++ optional lang.dart.enable pkgs.dart
        ++ optional lang.elixir.enable pkgs.elixir-ls
        ++ optional lang.elm.enable pkgs.elmPackages.elm-elm-language-server
        ++ optional lang.erlang.enable pkgs.erlang-ls
        ++ optional lang.fortran.enable pkgs.fortls
        ++ optional lang.fsharp.enable pkgs.fsautocomplete
        ++ optional lang.go.enable pkgs.gopls
        ++ optional lang.html-css.enable pkgs.vscode-css-languageserver
        ++ optional lang.idris.enable pkgs.idris2Packages.idris2Lsp
        ++ optional lang.java.enable pkgs.jdt-language-server
        ++ optional lang.lean.enable pkgs.lean4
        ++ optional lang.lua.enable pkgs.lua-language-server
        ++ optional lang.ocaml.enable pkgs.ocaml
        ++ optional lang.perl.enable pkgs.perlnavigator
        ++ optional lang.prolog.enable pkgs.swi-prolog
        ++ optional lang.r.enable (pkgs.rWrapper.override{ packages = [ pkgs.rPackages.languageserver ];})
        ++ optional lang.racket.enable pkgs.racket
        ++ optional lang.ruby.enable pkgs.solargraph
        ++ optional lang.scala.enable pkgs.metals
        ++ optionals lang.c.enable [ pkgs.clang-tools pkgs.lldap ]
        ++ optionals lang.dotnet.enable [ pkgs.omnisharp-roslyn pkgs.netcoredbg ]
        ++ optionals lang.fennel.enable [ pkgs.fennel-ls pkgs.fnlfmt ]
        ++ optionals lang.haskell.enable [ pkgs.haskell-language-server pkgs.ormolu ]
        ++ optionals lang.purescript.enable [ pkgs.nodePackages.purescript-language-server pkgs.nodePackages.purs-tidy  ]
        ++ optionals lang.python.enable [ pkgs.python3Packages.python-lsp-server pkgs.python3Packages.python-lsp-ruff ]
        ++ optionals lang.rust.enable [ pkgs.rust-analyzer pkgs.lldap ]
        ++ optionals lang.zig.enable [ zls lldap ]
      ;
    };

    myHome.stylix.enable = true;
    programs.helix = {
      themes = {
        stylix-custom = {
          inherits = "stylix";

          "ui.statusline.normal" = { fg = "base00"; bg = "base0D"; };
          "ui.bufferline.active" = { fg = "base00"; bg = "base0D"; modifiers = ["bold"]; };
          "ui.cursor.primary" = { fg = "base0D"; modifiers = ["reversed"]; };
          "ui.cursor.match" = { fg = "base0D"; underline.style = "line"; };
          # "ui.cursor.select" = { fg = "base0A"; modifiers = ["reversed"]; };
        };
      };
    };
  };
}
