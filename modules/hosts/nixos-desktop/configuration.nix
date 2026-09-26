{ config, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../fonts.nix
    ../../git
    ../../limine.nix
    ../../nh.nix
    ../../nvidia.nix
    ../../pipewire.nix
    ../../plymouth.nix
    ../../zsh
  ];

  boot.loader.limine.extraEntries = ''
    /CachyOS
    comment: CachyOS
    protocol: efi
    path: uuid(1c088854-8d4d-4a4a-9b31-510361bb1565):/EFI/BOOT/BOOTX64.EFI
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  programs.steam.enable = true;
  services.tailscale.enable = true;

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  users.users."max" = {
    isNormalUser = true;
    extraGroups = [
      "max"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    initialPassword = "max"; # for build-vm
  };

  environment.systemPackages = with pkgs; [
    (callPackage ../../scripts/switch-audio-profile.nix { })
    fastfetch
    itgmania
    osu-lazer-bin
    qbittorrent
    spotify
    tree
    unrar
    vesktop
    vscodium-fhs
    wineWow64Packages.stable
    winetricks
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    cores = 4;
    memorySize = 8192;
  };

  system.stateVersion = "26.11";
}
