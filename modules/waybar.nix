{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.main = {
      margin = "4 0 2 0";
      spacing = 8;

      modules-left = [
        "niri/workspaces"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "battery"
        "network"
      ];

      clock = {
        format = "{:%r}";
        interval = 1;
        tooltip-format = "{calendar}";
        calendar.format.today = "<span color='#a7c080'><b><u>{}</u></b></span>";
        actions = {
          on-click = "shift_up";
          on-click-right = "shift_down";
          on-click-middle = "shift_reset";
        };
      };

      cpu = {
        states = {
          warning = 50;
          critical = 90;
        };
        format = "";
        format-alt = "{usage}% ";
      };

      memory = {
        states = {
          warning = 75;
          critical = 90;
        };
        format = "";
        format-alt = "{percentage}% ";
        tooltip-format = "{used:0.1f}/{total:0.1f} GiB";
      };

      battery = {
        states = {
          warning = 50;
          critical = 20;
        };
        format = "{icon}";
        format-alt = "{capacity}% {icon}";
        tooltip-format = "{capacity}% {timeTo}";
        format-icons = {
          default = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          charging = [
            "󰢟"
            "󰢜"
            "󰂆"
            "󰂇"
            "󰂈"
            "󰢝"
            "󰂉"
            "󰢞"
            "󰂊"
            "󰂋"
            "󰂅"
          ];
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
