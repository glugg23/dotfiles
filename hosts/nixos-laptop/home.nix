{ config, pkgs, ... }:

{
  imports = [
    ../../modules/easyeffects.nix
    ../../modules/firefox.nix
    ../../modules/kitty.nix
    ../../modules/mpv.nix
    ../../modules/niri.nix
    ../../modules/waybar.nix
    ../../modules/zsh.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

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

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  home.stateVersion = "25.11";
}
