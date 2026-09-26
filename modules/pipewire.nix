{ hostname, ... }:

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
                  "node.name" =
                    if (hostname == "nixos-desktop") then
                      "alsa_output.pci-0000_0c_00.4.iec958-stereo"
                    else
                      "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K7-00.analog-stereo";
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
