{
  lib,
  pkgs,
  config,
  ...
}:

{
  options.spotify.custom.enable = lib.options.mkEnableOption "enable custom spotify version";

  config =
    let
      cfg = config.spotify.custom;
      deps = with pkgs; [
        libayatana-indicator
        ayatana-ido
      ];
      spotify = pkgs.spotify.overrideAttrs (
        finalAttrs: previousAttrs: {
          version = "1.2.84.475.ga1a748ff";
          rev = "93";
          src = pkgs.fetchurl {
            name = "spotify-${finalAttrs.version}-${finalAttrs.rev}.snap";
            url = "https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_${finalAttrs.rev}.snap";
            hash = "sha512-X9IslXh1MHExJpBu45mXnIowdhmvkBko+fupk23WhKNoUPSR37jbj5Ee4V2ZYKxCtgyDgX8Px1YKynu3KEVUFg==";
          };
          env = previousAttrs.env // {
            librarypath = "${pkgs.lib.makeLibraryPath deps}:${previousAttrs.env.librarypath}";
          };
        }
      );
    in
    {
      environment.systemPackages = if cfg.enable then [ spotify ] else [ pkgs.spotify ];
    };
}
