final: prev: {
  gallery-dl = prev.gallery-dl.overridePythonAttrs (oldAttrs: {
    version = "1.32.12-dev";

    src = prev.fetchFromCodeberg {
      owner = "HumanManFromEarth";
      repo = "gallery-dl";
      rev = "78aa2542a2438831b33e68f4fe291bd15cb61cc3";
      hash = "sha256-D0FPJXGDi2tY7ggWNRbKF3vOtVqmh3GNA/7AQQ/aGJc=";
    };

    dependencies = oldAttrs.dependencies ++ [
      final.python3Packages.curl-cffi
    ];
  });
}
