{ config, pkgs, ... }:

{
  imports = [
    ../../easyeffects.nix
    ../../firefox.nix
    ../../fuzzel.nix
    ../../kitty.nix
    ../../mpv.nix
    ../../neovim.nix
    ../../noctalia.nix
    ../../vim.nix
    ../../wm/wayland/niri/home.nix
    ../../zsh/home.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

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
    enable = true;
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
