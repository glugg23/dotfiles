{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems = {
    "/".options = [ "defaults" "noatime" "compress=zstd:1" "commit=120" ];
    "/home".options = [ "defaults" "noatime" "compress=zstd:1" "commit=120" ];
    "/root".options = [ "defaults" "noatime" "compress=zstd:1" "commit=120" ];
    "/nix".options = [ "defaults" "noatime" "compress=zstd:1" "commit=120" ];
    "/var/cache".options = [ "defaults" "noatime" "compress=zstd:1" "commit=120" ];
    "/var/tmp".options = [ "defaults" "noatime" "compress=zstd:1" "commit=120" ];
    "/var/log".options = [ "defaults" "noatime" "compress=zstd:1" "commit=120" ];
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

  services.displayManager.ly = {
    enable = true;
    settings = {
      bigclock = "en";
      bigclock_12hr = true;
      bigclock_seconds = true;
      brightness_down_key = "F7";
      brightness_up_key = "F8";
      clear_password = true;
      clock = "%d/%m/%Y";
      default_input = "password";
    };
  };
  programs.niri.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.max = {
    isNormalUser = true;
    extraGroups = [ "max" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    fastfetch
    fuzzel
    git
    playerctl
    tree
    swaybg
    vim
    xwayland-satellite
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
