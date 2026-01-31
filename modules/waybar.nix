{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.main = {
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-right = [ "battery" "clock" ];

      "clock" = {
        format = "{:%d/%m/%Y %r}";
        interval = 1;
      };

      "niri/window"."format" = "{app_id}";
    };
    style = ../config/waybar/style.css;
  };
}
