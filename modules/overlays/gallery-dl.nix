final: prev: {
  gallery-dl = prev.gallery-dl.overridePythonAttrs (oldAttrs: {
    version = "1.33.0-dev";

    src = prev.fetchFromCodeberg {
      owner = "HumanManFromEarth";
      repo = "gallery-dl";
      rev = "1222ff1b11689d7a0c72bb3ec8cf2a2378c57dd5";
      hash = "sha256-HdnZaLgDH32HYw3gtceMphv6jb5aqIUdvDUJZYUmsrM=";
    };

    dependencies = oldAttrs.dependencies ++ [
      final.python3Packages.curl-cffi
    ];
  });
}
