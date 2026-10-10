{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    kate
    konsole
    ktexteditor
    okular
    plasma-browser-integration
    qrca
  ];
  programs.kde-pim.enable = false;
}
