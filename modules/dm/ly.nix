{ ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      bigclock = "en";
      bigclock_12hr = true;
      bigclock_seconds = true;
      brightness_down_key = "F7";
      brightness_up_key = "F8";
      clear_password = true;
      clock = "%d/%m/%Y";
      default_input = "password";
    };
  };
}
