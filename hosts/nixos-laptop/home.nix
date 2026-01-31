{ config, pkgs, ... }:

{
  imports = [
    ../../modules/firefox.nix
    ../../modules/kitty.nix
    ../../modules/niri.nix
    ../../modules/waybar.nix
    ../../modules/zsh.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
  };

  home.stateVersion = "25.11";
}
