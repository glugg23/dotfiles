final: prev: {
  gallery-dl = prev.gallery-dl.overridePythonAttrs (oldAttrs: {
    version = "1.33.0-dev";

    src = prev.fetchFromCodeberg {
      owner = "HumanManFromEarth";
      repo = "gallery-dl";
      rev = "a0aa7a7c6b8cb0152cb06bf29d2c6bec90bba4a3";
      hash = "sha256-BBlrKMN8vV0scltVnK3MEykmqbHESUQsHTbKN6zjhtc=";
    };

    dependencies = oldAttrs.dependencies ++ [
      final.python3Packages.curl-cffi
    ];
  });
}
