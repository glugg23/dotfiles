{ pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../fonts.nix
    ../../git
    ../../limine.nix
    ../../nh.nix
    ../../nix.nix
    ../../nvidia.nix
    ../../pipewire.nix
    ../../plymouth.nix
    ../../zsh
  ];

  nixpkgs.overlays = [
    (import ../../overlays/gallery-dl.nix)
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

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    kate
    konsole
    ktexteditor
    okular
    plasma-browser-integration
    qrca
  ];

  services.tailscale.enable = true;

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    (callPackage ../../scripts/switch-audio-profile.nix { })
    fastfetch
    gallery-dl
    itgmania
    lutris
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

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    cores = 4;
    memorySize = 8192;
  };

  system.stateVersion = "26.11";
}
