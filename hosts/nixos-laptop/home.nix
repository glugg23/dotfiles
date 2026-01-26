{ config, pkgs, ... }:

{
  imports = [
    ../../modules/zsh.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  home.stateVersion = "25.11";
}
