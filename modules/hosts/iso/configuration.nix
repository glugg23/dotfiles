{
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../nh.nix
    ../../zsh
  ];

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  users.users.nixos = {
    shell = pkgs.zsh;
    initialHashedPassword = lib.mkForce "$y$j9T$6lixZcT1OFkJEsy76yyTz/$yuuBikCUy4n6OUhyxrmX6WsMU4jxEz.JoxWgk6qHSu9";
  };

  environment.systemPackages = with pkgs; [
    (callPackage ../../scripts/nixos-installer.nix { })
    disko
    htop
    tree
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
