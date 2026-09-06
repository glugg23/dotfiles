{
  disko.devices = {
    disk = {
      vda = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "4G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content =
                let
                  mounts = {
                    "/@" = "/";
                    "/@home" = "/home";
                    "/@root" = "/root";
                    "/@nix" = "/nix";
                    "/@cache" = "/var/cache";
                    "/@tmp" = "/var/tmp";
                    "/@log" = "/var/log";
                  };
                  buildSubVolumes =
                    attrs:
                    builtins.mapAttrs (k: v: {
                      mountpoint = v;
                      mountOptions = [
                        "defaults"
                        "noatime"
                        "compress=zstd:1"
                        "commit=120"
                      ];
                    }) attrs;
                in
                {
                  type = "btrfs";
                  subvolumes = buildSubVolumes mounts;
                };
            };
          };
        };
      };
    };
  };
}
