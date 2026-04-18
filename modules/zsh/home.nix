{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nixos-update = "nix flake update --flake ~/dotfiles --commit-lock-file && nh os switch -a";
    };
    sessionVariables = {
      EDITOR = "vim";
    };
  };
}
