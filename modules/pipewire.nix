{ ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        "fiio-k7" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "node.name" = "alsa_output.pci-0000_0c_00.4.iec958-stereo";
                }
              ];
              actions = {
                update-props = {
                  "resample.quality" = 10;
                  "resample.disable" = false;
                  "audio.rate" = 96000;
                  "audio.allowed-rates" = "32000, 44100, 48000, 96000";
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
          ];
        };
      };
    };
  };
}
