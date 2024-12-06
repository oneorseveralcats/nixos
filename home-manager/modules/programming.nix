{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.programming;
  x86_packages = with pkgs; [ purescript spago ];
  haskellPackages = with pkgs.haskellPackages; [ brick turtle ];
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
      ghc gcc
      lua
      python3
      rustc # R_env
    ] ++ haskellPackages
      ++ (if pkgs.system == "aarch64-linux" then
        []
      else if pkgs.system == "x86_64-linux" then
        x86_packages
      else
        [])
;
  
    home.shellAliases = {
      sbcl = "${pkgs.rlwrap}/bin/rlwrap ${pkgs.sbcl}/bin/sbcl";
      fennel = "${pkgs.fennel}/bin/fennel --lua lua";
    };

    home.file.".haskeline".text = ''
      editMode: Vi
    '';
    home.file.".ghci".text = ''
      :set prompt "λ> "
    '';

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    services.lorri.enable = true;

    services.ssh-agent.enable = true;

    programs.git = {
      enable = true;
      extraConfig = {
        user = {
          email = ".";
          name = ".";
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
