{ pkgs, modulesPath, lib, ... }: {

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PasswordAuthentication = false;
  #     KbdInteractiveAuthentication = false;
  #   };
  # };

  programs.ssh.startAgent = true;
  
  users.users.nixos = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEF3AgrAGuIauOJs9U4MyYz+JeA4CDzyfQFXMYutODpv user"
    ];
  };
}
