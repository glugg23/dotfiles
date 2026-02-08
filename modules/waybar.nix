{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.main = {
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "battery" "network" ];

      clock = {
        format = "{:%d/%m/%Y %r}";
        interval = 1;
      };

      battery = {
        states = {
          good = 80;
          warning = 50;
          critical = 20;
        };
        format = "{capacity}% {icon}";
        format-icons = {
          default = [ "󰂎" "󰁻" "󰁾" "󰂀" "󰁹" ];
          charging = [ "󰢟" "󰂆" "󰢝" "󰢞" "󰂅" ];
        };
      };

      network = {
        format-wifi = "󰖩";
        format-ethernet = "󰈀";
        format-disconnected = "󰖪";
        tooltip-format = "{essid}";
      };

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          main = "󰹑";
          discord = "";
        };
      };

      "niri/window".format = "{app_id}";
    };
    style = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/waybar/style.css";
  };
}
