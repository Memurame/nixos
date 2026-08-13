{ ... }:

{
  imports = [
    ../../modules/common.nix
    ./hardware-configuration.nix
  ];

  # Host-spezifisch
  networking.hostName = "nixos";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Diese Version nicht ändern, wenn sie deiner ursprünglichen
  # Installation entspricht.
  system.stateVersion = "26.05";
}
