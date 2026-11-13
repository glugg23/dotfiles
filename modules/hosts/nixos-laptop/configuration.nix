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
    ../../plymouth.nix
    ../../podman/nixos.nix
    ../../zsh
  ];

  nixpkgs.overlays = [
    (import ../../overlays/dolphin.nix)
  ];

  hardware.bluetooth.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.zswap.enable = true;
  swapDevices = [ { device = "/.swap/swapfile"; } ];

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
    settings.publish = {
      publish-addresses = true;
      publish-workstation = true;
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
    kdePackages.gwenview
    libreoffice-qt-stable
    obsidian
    pavucontrol
    qbittorrent
    spotify
    tree
    vesktop
    yazi
  ];

  systemd.services.toggle-wireless-sleep =
    let
      target = [ "sleep.target" ];
      command = state: ''
        ${pkgs.networkmanager}/bin/nmcli radio wifi ${state} || true
        ${pkgs.bluez}/bin/bluetoothctl power ${state} || true
      '';
    in
    {
      description = "Toggle WiFi and Bluetooth for sleep";
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
      };
      unitConfig.StopWhenUnneeded = true;
      wantedBy = target;
      before = target;
      script = command "off"; # turn off wifi before sleep
      preStop = command "on"; # turn on wifi after sleep
    };

  users.users.max = {
    isNormalUser = true;
    extraGroups = [
      "max"
      "wheel"
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$gOnjuoA8TAbuXxDP.DQuV/$Rs/32JtuGKtdVy2J8QZsHqzcErS2sFs/zf8IBMVuNRC";
  };

  virtualisation.vmVariantWithBootLoader.virtualisation = {
    cores = 4;
    memorySize = 8192;
  };

  system.stateVersion = "25.11";
}
