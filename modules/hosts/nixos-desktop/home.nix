{ config, pkgs, ... }:

{
  imports = [
    ../../firefox.nix
    ../../kitty.nix
    ../../neovim.nix
    ../../zsh/home.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  home.stateVersion = "26.11";
}
