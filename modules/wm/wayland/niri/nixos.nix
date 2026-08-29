{ pkgs, ... }:

{
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
  };
}
