{
  fileSystems =
    let
      defaults = [
        "defaults"
        "noatime"
        "compress=zstd:1"
        "commit=120"
      ];
    in
    {
      "/".options = defaults;
      "/home".options = defaults;
      "/root".options = defaults;
      "/nix".options = defaults;
      "/var/cache".options = defaults;
      "/var/tmp".options = defaults;
      "/var/log".options = defaults;
      "/tmp".fsType = "tmpfs";
    };
}
