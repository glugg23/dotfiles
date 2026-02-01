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

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          discord = "";
        };
      };

      "niri/window".format = "{app_id}";
    };
    style = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/waybar/style.css";
  };
}
