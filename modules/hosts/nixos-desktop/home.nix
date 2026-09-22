{ config, pkgs, ... }:

{
  imports = [
    ../../cursor.nix
    ../../firefox.nix
    ../../git/home.nix
    ../../kitty.nix
    ../../mpv.nix
    ../../neovim.nix
    ../../zsh/home.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  home.stateVersion = "26.11";
}
