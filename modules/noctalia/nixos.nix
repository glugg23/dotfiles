{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    noctalia
    noctalia-greeter
  ];

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      auth.allow_empty_password = true;
      cursor.size = 24;
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
    };
  };
}
