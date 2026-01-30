{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.desktop.base;
in
{
  options.myHome.desktop.base = {
    enable = lib.mkEnableOption "Enable all the standard desktop packages and settings.";
  };

  config = mkIf cfg.enable {
    myHome.media.zathura.enable = true;

    home.packages = with pkgs; [
      anki
      deluge
      gimp3-with-plugins
      keepassxc
      nb
      udiskie usbimager
      xournalpp

      dconf
      hicolor-icon-theme
      adwaita-icon-theme gnome-themes-extra
    ] ++
      (if pkgs.stdenv.hostPlatform.system == "aarch64-linux" then
        [ pkgs.box64 pkgs.box86 ]
      else
        [])
    ;

    home.file.".XCompose".text = ''
      include "%L"
      <Multi_key> <l> <l> : "λ"
    '';

    #   <Multi_key> <\> <a> : "α"
    #   <Multi_key> <\> <b> : "β"
    #   <Multi_key> <\> <g> : "γ"
    #   <Multi_key> <\> <d> : "δ"
    #   <Multi_key> <\> <e> <p> : "ε"
    #   <Multi_key> <\> <z> : "ζ"
    #   <Multi_key> <\> <e> <t> : "η"
    #   <Multi_key> <\> <t> <h> : "θ"
    #   <Multi_key> <\> <i> : "ι"
    #   <Multi_key> <\> <k> : "κ"
    #   <Multi_key> <\> <l> : "λ"
    #   <Multi_key> <\> <m> : "μ"
    #   <Multi_key> <\> <n> : "ν"
    #   <Multi_key> <\> <x> : "ξ"
    #   <Multi_key> <\> <o> <m> <i> : "ο"
    #   <Multi_key> <\> <p> <i> : "π"
    #   <Multi_key> <\> <r> : "ρ"
    #   <Multi_key> <\> <s> : "σ"
    #   <Multi_key> <\> <t> <a> : "τ"
    #   <Multi_key> <\> <u> : "υ"
    #   <Multi_key> <\> <p> <h> : "φ"
    #   <Multi_key> <\> <c> : "χ"
    #   <Multi_key> <\> <p> <s> : "ψ"
    #   <Multi_key> <\> <o> <m> <e> : "ω"

    #   <Multi_key> <\> <A> : "Α"
    #   <Multi_key> <\> <B> : "Β"
    #   <Multi_key> <\> <G> : "Γ"
    #   <Multi_key> <\> <D> : "Δ"
    #   <Multi_key> <\> <E> <P> : "Ε"
    #   <Multi_key> <\> <Z> : "Ζ"
    #   <Multi_key> <\> <E> <T> : "Η"
    #   <Multi_key> <\> <T> <H> : "Θ"
    #   <Multi_key> <\> <I> : "Ι"
    #   <Multi_key> <\> <K> : "Κ"
    #   <Multi_key> <\> <L> : "Λ"
    #   <Multi_key> <\> <M> : "Μ"
    #   <Multi_key> <\> <N> : "Ν"
    #   <Multi_key> <\> <X> : "Ξ"
    #   <Multi_key> <\> <O> <M> <I> : "Ο"
    #   <Multi_key> <\> <P> <I> : "Π"
    #   <Multi_key> <\> <R> : "Ρ"
    #   <Multi_key> <\> <S> : "Σ"
    #   <Multi_key> <\> <T> <A> : "Τ"
    #   <Multi_key> <\> <U> : "Υ"
    #   <Multi_key> <\> <P> <H> : "Φ"
    #   <Multi_key> <\> <C> : "Χ"
    #   <Multi_key> <\> <P> <S> : "Ψ"
    #   <Multi_key> <\> <O> <M> <E> : "Ω"
    # '';

    services.udiskie = {
      enable = true;
      notify = true;
    };
  };
}
