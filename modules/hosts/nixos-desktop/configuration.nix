{ config, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../fonts.nix
    ../../git
    ../../limine.nix
    ../../nh.nix
    ../../pipewire.nix
    ../../zsh
  ];

  boot.loader.limine.extraEntries = ''
    /CachyOS
    comment: CachyOS
    protocol: efi
    path: uuid(1c088854-8d4d-4a4a-9b31-510361bb1565):/EFI/BOOT/BOOTX64.EFI
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  fileSystems."/tmp".fsType = "tmpfs";
  zramSwap.enable = true;

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  services.xserver.xkb.layout = "gb";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

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
