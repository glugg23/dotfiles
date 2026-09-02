{ pkgs, modulesPath, ... }:

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
  };

  environment.systemPackages = with pkgs; [
    (callPackage ../../scripts/nixos-installer.nix {})
    disko
    tree
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
