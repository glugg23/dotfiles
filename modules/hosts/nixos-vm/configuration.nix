{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../nh.nix
    ../../zsh
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm";

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = "uk";
  };

  users.users.max = {
    isNormalUser = true;
    extraGroups = [
      "max"
      "wheel"
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$HuQzMgRNfOhCHmbGB25C1/$/NRhjPej3LruxcAP8YUxYv3r3EOrGMIHwSdO/WshzrB";
  };

  environment.systemPackages = with pkgs; [
    git
    tree
  ];

  services.openssh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
