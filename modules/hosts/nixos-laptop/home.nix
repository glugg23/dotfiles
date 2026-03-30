{ config, pkgs, ... }:

{
  imports = [
    ../../wm/wayland/niri/home.nix
    ../../easyeffects.nix
    ../../firefox.nix
    ../../fuzzel/home.nix
    ../../kitty.nix
    ../../mpv.nix
    ../../waybar.nix
    ../../zsh.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  home.packages =
    let
      swww-background = pkgs.callPackage ../../scripts/swww-background.nix {
        homeDirectory = config.home.homeDirectory;
      };
    in
    [ swww-background ];

  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  xdg.configFile.kdeglobals.source = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";

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
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
    gtk4.theme = null;
  };

  qt = {
    enable = true;
    style.name = "breeze";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  home.stateVersion = "25.11";
}
