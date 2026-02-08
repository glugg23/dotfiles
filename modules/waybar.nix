{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.main = {
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "battery" "network" ];

      "niri/workspaces" = {
        format = "{icon}";
      };

      "niri/window".format = "{app_id}";

      clock = {
        format = "{:%d/%m/%Y %r}";
        interval = 1;
      };

      cpu = {
        states = {
          warning = 50;
          critical = 90;
        };
        format = "{usage}% ";
      };

      memory = {
        states = {
          warning = 75;
          critical = 90;
        };
        format = "{percentage}% ";
        tooltip-format = "{used:0.1f}/{total:0.1f} GiB";
      };

      battery = {
        states = {
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
    };

    style = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/waybar/style.css";
  };
}
