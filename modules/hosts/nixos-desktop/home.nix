{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:

{
  imports = [
    ../../cursor.nix
    ../../firefox.nix
    ../../git/home.nix
    ../../kitty.nix
    ../../mpv.nix
    ../../neovim.nix
    ../../podman/home.nix
    ../../zsh/home.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "192.168.122.*" = lib.mkIf osConfig.programs.virt-manager.enable {
        "StrictHostKeyChecking" = "no";
        "UserKnownHostsFile" = "/dev/null";
        "GlobalKnownHostsFile" = "/dev/null";
      };
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };
    };
  };

  home.stateVersion = "26.11";
}
