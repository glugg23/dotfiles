{ config, pkgs, ... }:

{
  imports = [
    ../../modules/zsh.nix
    ../../modules/niri.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  home.stateVersion = "25.11";
}
