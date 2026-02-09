{ pkgs, ... }:

let
  deps = with pkgs; [
    libayatana-indicator
    ayatana-ido
  ];
  spotify = pkgs.spotify.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "1.2.79.427.g80eb4a07";
      rev = "91";
      src = pkgs.fetchurl {
        name = "spotify-${finalAttrs.version}-${finalAttrs.rev}.snap";
        url = "https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_${finalAttrs.rev}.snap";
        hash = "sha512-wPg5J7xZUanyWQLO34IG/feXzI/4ljBh8bShqNgZJnG3yMb65v0Qxy7LoaoPqpmItEvlANhoA0esGCTVn4/5kA==";
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
