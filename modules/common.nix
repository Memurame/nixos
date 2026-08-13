{ config, pkgs, ... }:

{
  # Allgemeine Systemkonfiguration
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "de_CH.UTF-8";

  # KDE Plasma 6
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  # SDDM Display Manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Schweizer Tastaturbelegung
  services.xserver.xkb = {
    layout = "ch";
    variant = "";
  };

  console.keyMap = "sg";

  # Drucken
  services.printing.enable = true;

  # Audio mit PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Benutzer
  users.users.manfred = {
    isNormalUser = true;
    description = "Manfred";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Firefox
  programs.firefox.enable = true;

  # Unfreie Pakete erlauben
  nixpkgs.config.allowUnfree = true;

  # Installierte Systempakete
  environment.systemPackages = with pkgs; [
    proton-pass
    proton-vpn
    git
    wget
    virtualbox
    protonmail-desktop
    claude-code
    gparted
    libreoffice
    signal-desktop
    spotify
    wireshark
    vlc
    qFlipper
    ungoogled-chromium
  ];

  # Flipper Zero
  hardware.flipperzero.enable = true;

  # Standardbrowser
  xdg.mime.enable = true;

  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  # Git
  programs.git = {
    enable = true;

    config = {
      safe.directory = "/etc/nixos";
    };
  };

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "manfred" ];

  # Firewall
  #
  # Nur deaktivieren, wenn du das wirklich möchtest.
  networking.firewall.enable = false;

  # Flakes und neues Nix-Kommando
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
