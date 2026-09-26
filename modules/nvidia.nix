{
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
