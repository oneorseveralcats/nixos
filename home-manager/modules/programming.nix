{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming;
  x86_packages = with pkgs; [ purescript spago ];
  haskell_packages = with pkgs.haskellPackages; [ brick turtle ];
  # R_env = pkgs.rWrapper.override{ packages = with pkgs.rPackages; [ languageserver ]; };
in
{
  options.myHome.programming = {
    enable = lib.mkOption {
      description = "Enable programming languages and configurations.";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dotnet-runtime
      elmPackages.elm
      # fennel
      ghc gcc
      lua
      python3
      rustc # R_env
    ] ++ haskell_packages
      ++ (if pkgs.system == "aarch64-linux" then
        []
      else if pkgs.system == "x86_64-linux" then
        x86_packages
      else
        [])
    ;

    home.shellAliases = {
      lg = "${pkgs.lazygit}/bin/lazygit";
      sbcl = "${pkgs.rlwrap}/bin/rlwrap ${pkgs.sbcl}/bin/sbcl";
    };

    programs.helix = {
      extraPackages = with pkgs; [
        marksman
        nil nodePackages.bash-language-server

        clang-tools
        elmPackages.elm-language-server
        haskellPackages.haskell-language-server
        # jdt-language-server
        lua-language-server
        python3Packages.python-lsp-server
        yaml-language-server
      ];
    };
  
    home.file.".haskeline".text = ''
      editMode: Vi
    '';
    home.file.".ghci".text = ''
      :set prompt "λ> "
    '';

    programs.direnv = {
      enable = false;
      nix-direnv.enable = true;
    };

    services.ssh-agent.enable = true;

    programs.git = {
      enable = true;
      extraConfig = {
        user = {
          email = "oneorseveralcats@noreply.codeberg.org";
          name = "oneorseveralcats";
          signingkey = "~/.ssh/oosc.pub";
        };
        gpg = {
          format = "ssh";
        };
        commit = {
          gpgSign = true;
        };
      };
    };
    programs.lazygit = {
      enable = true;
    };
  };
}
