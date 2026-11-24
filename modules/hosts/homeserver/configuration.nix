{ pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../nh.nix
    ../../zsh
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # TODO: Check if we need to use a specific ZFS kernel version
  # https://wiki.nixos.org/wiki/ZFS#Selecting_the_latest_ZFS-compatible_Kernel
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs = {
    forceImportRoot = false;
    # devNodes = "/dev/disk/by-partuuid";
  };
  boot.tmp.useTmpfs = true;

  networking.hostName = "homeserver";
  # TODO: Set this to a fixed random number once installed
  # Must do initial reboot with zfs_force=1 kernel param
  # Or can fetch the value used from the install iso with `hostid`
  networking.hostId = "abcd1234";

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  # TODO: Disable password login once setup, available as a back up if tailscale fails
  services.openssh.enable = true;
  services.zfs.autoScrub.enable = true;

  environment.systemPackages = with pkgs; [
    git
    tree
  ];

  users.users.max = {
    isNormalUser = true;
    extraGroups = [
      "max"
      "wheel"
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$gOnjuoA8TAbuXxDP.DQuV/$Rs/32JtuGKtdVy2J8QZsHqzcErS2sFs/zf8IBMVuNRC";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.11";
}
