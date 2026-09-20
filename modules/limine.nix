{
  boot.loader.limine = {
    enable = true;
    extraConfig = ''
      remember_last_entry: yes
    '';
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
