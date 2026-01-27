{ config, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.main = {
      modules-right = [ "clock" ];

      "clock" = {
        format = "{:%I:%M:%S %p %d/%m/%Y}";
        interval = 1;
      };
    };
  };
}
