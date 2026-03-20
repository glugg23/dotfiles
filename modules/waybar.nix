{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.main = {
      margin = "4 0 2 0";
      spacing = 8;

      modules-left = [
        "niri/workspaces"
        "tray"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "battery"
        "power-profiles-daemon"
        "wireplumber"
        "network"
      ];

      "niri/workspaces" = {
        cursor = true;
      };

      tray = {
        spacing = 8;
      };

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
        tooltip = false; # this can be true if tooltip-format is added
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
        format = "{capacity}% {icon}";
        tooltip-format = "{timeTo}";
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
          plugged = "󰂅";
        };
      };

      power-profiles-daemon = {
        tooltip-format = "{profile}";
        format-icons = {
          performance = "󱓞";
          balanced = "󰊚";
          power-saver = "󰌪";
        };
      };

      wireplumber = {
        format = "{volume}% {icon}";
        format-muted = "0% 󰝟";
        format-icons = [
          "󰕿"
          "󰖀"
          "󰕾"
        ];
        on-click = "pavucontrol";
        on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      network = {
        interval = 10;
        on-click-right = "kitty nmtui";
        format = "{icon}";
        format-alt = "{bandwidthTotalBytes} {icon}";
        tooltip-format-wifi = "{essid} ({signalStrength}%) {icon}";
        tooltip-format-ethernet = "{bandwidthDownBytes} down {bandwidthUpBytes} up";
        tooltip-format-disconnected = "Disconnected!";
        format-icons = {
          wifi = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          ethernet = "󰈀";
          disconnected = "󰤮";
        };
      };
    };

    style = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/waybar/style.css";
  };
}
