{
  disko.devices = {
    disk = {
      nvme0 = {
        # TODO: Replace this with a /dev/disk/by-id device once assembled
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "16G";
              content = {
                type = "swap";
                discardPolicy = "both";
                randomEncryption = true;
              };
            };
            rpool = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
      sda = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions.dpool = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "dpool";
            };
          };
        };
      };
      sdb = {
        device = "/dev/sdb";
        type = "disk";
        content = {
          type = "gpt";
          partitions.dpool = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "dpool";
            };
          };
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";
        # TODO: Update this to mirror once second nvme drive installed
        # mode = "mirror";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          canmount = "off";
          compression = "lz4";
          dnodesize = "auto";
          mountpoint = "none";
          xattr = "sa";
        };
        datasets =
          let
            mkDataSet = m: {
              type = "zfs_fs";
              options.mountpoint = "legacy";
              mountpoint = m;
            };
          in
          {
            "os" = mkDataSet "/";
            "os/nix" = mkDataSet "/nix";
            "os/var" = mkDataSet "/var";
            "os/home" = mkDataSet "/home";
          };
      };
      dpool = {
        type = "zpool";
        # TODO: Change this to raidz when adding 2 more drives
        mode = "mirror";
        options.ashift = "12";
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          canmount = "off";
          compression = "lz4";
          dnodesize = "auto";
          mountpoint = "none";
          # recordsize = "1M";
          xattr = "sa";
        };
        datasets =
          let
            mkDataSet = m: {
              type = "zfs_fs";
              mountpoint = m;
            };
          in
          {
            # Create with `sudo zfs create -o mountpoint=/mnt/jellyfin dpool/jellyfin`
            # "jellyfin" = mkDataSet "/mnt/jellyfin";
          };
      };
    };
  };
}
