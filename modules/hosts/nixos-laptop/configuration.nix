{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../dm/ly.nix
    ../../lid-guard.nix
    ../../nh.nix
    ../../pipewire.nix
    ../../spotify
    ../../wm/wayland/niri/nixos.nix
    ../../zsh
  ];

  nixpkgs.overlays = [
    (import ../../overlays/dolphin.nix)
  ];

  hardware.bluetooth.enable = true;

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems = {
    "/".options = [
      "defaults"
      "noatime"
      "compress=zstd:1"
      "commit=120"
    ];
    "/home".options = [
      "defaults"
      "noatime"
      "compress=zstd:1"
      "commit=120"
    ];
    "/root".options = [
      "defaults"
      "noatime"
      "compress=zstd:1"
      "commit=120"
    ];
    "/nix".options = [
      "defaults"
      "noatime"
      "compress=zstd:1"
      "commit=120"
    ];
    "/var/cache".options = [
      "defaults"
      "noatime"
      "compress=zstd:1"
      "commit=120"
    ];
    "/var/tmp".options = [
      "defaults"
      "noatime"
      "compress=zstd:1"
      "commit=120"
    ];
    "/var/log".options = [
      "defaults"
      "noatime"
      "compress=zstd:1"
      "commit=120"
    ];
    "/tmp".fsType = "tmpfs";
  };
  zramSwap.enable = true;

  networking.hostName = "nixos-laptop";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = "uk";
  };

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  services.fprintd.lid-guard = {
    enable = true;
    lidPath = "LID0";
    extraPamServices = [ "login" ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.flatpak.enable = true;
  services.upower.enable = true;

  users.users.max = {
    isNormalUser = true;
    extraGroups = [
      "max"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.steam.enable = true;
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    fastfetch
    gimp
    git
    kdePackages.dolphin
    kdePackages.ffmpegthumbs
    libreoffice-qt-fresh
    noctalia
    obsidian
    playerctl
    qbittorrent
    tree
    vesktop
    yazi
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
  ];

  services.openssh.enable = true;
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
