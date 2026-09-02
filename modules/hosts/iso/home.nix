{ ... }:

{
  imports = [
    ../../neovim.nix
    ../../zsh/home.nix
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "26.11";
}
