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

  systemd.services =
    let
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = false;
        User = "root";
      };
    in
    {
      disable-wireless-hibernate =
        let
          target = [
            "hibernate.target"
            "hybrid-sleep.target"
          ];
        in
        {
          description = "Disable WiFi and Bluetooth before hibernation";
          inherit serviceConfig;
          wantedBy = target;
          before = target;
          script = ''
            ${pkgs.networkmanager}/bin/nmcli radio wifi off || true
            ${pkgs.bluez}/bin/bluetoothctl power off || true
          '';
        };

      enable-wireless-resume =
        let
          target = [ "post-resume.target" ];
        in
        {
          description = "Enable WiFi and Bluetooth after resume";
          inherit serviceConfig;
          wantedBy = target;
          after = target;
          script = ''
            ${pkgs.networkmanager}/bin/nmcli radio wifi on || true
            ${pkgs.bluez}/bin/bluetoothctl power on || true
          '';
        };
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
