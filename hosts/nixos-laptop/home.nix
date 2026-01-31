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

  home.stateVersion = "25.11";
}
