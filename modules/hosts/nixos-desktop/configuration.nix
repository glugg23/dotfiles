{ config, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../limine.nix
    ../../nh.nix
    ../../pipewire.nix
    ../../zsh
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "gb";
  #   variant = "";
  # };

  users.users."max" = {
    isNormalUser = true;
    extraGroups = [
      "max"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    fastfetch
    git
    tree
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.11";
}
