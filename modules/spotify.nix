{ pkgs, ... }:

let
  deps = with pkgs; [
    libayatana-indicator
    ayatana-ido
  ];
  spotify = pkgs.spotify.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "1.2.82.428.g0ac8be2b";
      rev = "92";
      src = pkgs.fetchurl {
        name = "spotify-${finalAttrs.version}-${finalAttrs.rev}.snap";
        url = "https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_${finalAttrs.rev}.snap";
        hash = "sha512-/9lB4gLotYvM2QkHt8cKS8P4IXrBVzgoXEk4bWR3GQum0OnJqK/qCC9evmCZ7PAqbbyh5/8vSblM+QXXXiQiMA==";
      };
      env = previousAttrs.env // {
        librarypath = "${pkgs.lib.makeLibraryPath deps}:${previousAttrs.env.librarypath}";
      };
    }
  );
in
{
  environment.systemPackages = [ spotify ];
}
