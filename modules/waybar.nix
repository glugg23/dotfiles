{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.main = {
      modules-right = [ "clock" ];

      "clock" = {
        format = "{:%d/%m/%Y %r}";
        interval = 1;
      };
    };
    style = ../config/waybar/style.css;
  };
}
