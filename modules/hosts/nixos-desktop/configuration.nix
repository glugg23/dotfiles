{ lib, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../fonts.nix
    ../../git
    ../../kde.nix
    ../../limine.nix
    ../../nh.nix
    ../../nix.nix
    ../../nvidia.nix
    ../../pipewire.nix
    ../../plymouth.nix
    ../../podman/nixos.nix
    ../../virt-manager.nix
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

  fileSystems = {
    "/tmp".fsType = "tmpfs";
    "/mnt/Storage" = {
      device = "/dev/disk/by-uuid/68ff4fa3-ab84-4c11-b1d6-1397a9dc7579";
      fsType = "ext4";
    };
  };
  zramSwap.enable = true;

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  services.xserver.xkb.layout = "gb";

  services.displayManager.plasma-login-manager.enable = true;

  services.tailscale.enable = true;

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  services.udev.extraRules =
    let
      mkRule = as: lib.concatStringsSep ", " as;
      mkRules = rs: lib.concatStringsSep "\n" rs;
    in
    mkRules ([
      (mkRule [
        ''ACTION=="add|change"''
        ''SUBSYSTEM=="block"''
        ''KERNEL=="sd[a-z]"''
        ''ATTR{queue/rotational}=="1"''
        ''RUN+="${pkgs.hdparm}/bin/hdparm -B 90 -S 41 /dev/%k"''
      ])
    ]);

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    (callPackage ../../pkgs/rpgmaker-mv-decrypter.nix { })
    (callPackage ../../scripts/switch-audio-profile.nix { })
    fastfetch
    gallery-dl
    itgmania
    kdePackages.kcalc
    lutris
    obsidian
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
    description = "Max Leonhardt";
    isNormalUser = true;
    extraGroups = [
      "libvirtd"
      "max"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    initialPassword = "max"; # for build-vm
  };

  security.pki.caCertificateBlacklist =
    let
      noOverride = lib.versionAtLeast pkgs.cacert.version "3.131.1";
    in
    lib.warnIf noOverride
      ''
        cacert >= 3.131.1 is now in nixpkgs, the override can be removed.
      ''
      (
        if noOverride then
          [ ]
        else
          [
            "Comodo AAA Services root"
            "emSign ECC Root CA - G3"
          ]
      );

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    cores = 4;
    memorySize = 8192;
  };

  system.stateVersion = "26.11";
}
