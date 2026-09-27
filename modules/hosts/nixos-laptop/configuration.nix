{
  pkgs,
  ...
}:

{
  imports = [
    ./file-systems.nix
    ./hardware-configuration.nix
    ../../fonts.nix
    ../../git
    ../../lid-guard.nix
    ../../limine.nix
    ../../nh.nix
    ../../niri/nixos.nix
    ../../nix.nix
    ../../noctalia/nixos.nix
    ../../pipewire.nix
    ../../podman/nixos.nix
    ../../zsh
  ];

  nixpkgs.overlays = [
    (import ../../overlays/dolphin.nix)
  ];

  hardware.bluetooth.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  zramSwap.enable = true;

  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  services.libinput.enable = true;
  services.flatpak.enable = true;
  services.upower.enable = true;
  services.tailscale.enable = true;

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  services.fprintd.lid-guard = {
    enable = true;
    lidPath = "LID0";
    extraPamServices = [ "login" ];
  };

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  programs.steam.enable = true;
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    gimp
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.ffmpegthumbs
    libreoffice-qt-stable
    obsidian
    pavucontrol
    qbittorrent
    spotify
    tree
    vesktop
    yazi
  ];

  users.users.max = {
    isNormalUser = true;
    extraGroups = [
      "max"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.11";
}
