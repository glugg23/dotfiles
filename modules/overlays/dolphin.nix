final: prev: {
  kdePackages = prev.kdePackages.overrideScope (
    kfinal: kprev:
    let
      plasmaWorkspaceMenu = prev.stdenv.mkDerivation {
        name = "plasma-workspace-applications-menu";
        version = "6.6.4";

        src = prev.fetchFromGitLab {
          domain = "invent.kde.org";
          owner = "plasma";
          repo = "plasma-workspace";
          tag = "v6.6.4";
          sparseCheckout = [ "menu/desktop/plasma-applications.menu" ];
          hash = "sha256-KRfmKLv8R+e+82mIUsYqh4SNPmn3NbBfQ+nGF1wi02E=";
        };

        installPhase = ''
          mkdir -p $out/etc/xdg/menus
          cp ./menu/desktop/plasma-applications.menu $out/etc/xdg/menus/applications.menu
        '';
      };
    in
    {
      dolphin = prev.symlinkJoin {
        name = "dolphin-wrapped";
        paths = [ kprev.dolphin ];
        nativeBuildInputs = [ prev.makeWrapper ];
        postBuild = ''
          rm $out/bin/dolphin
          makeWrapper ${kprev.dolphin}/bin/dolphin $out/bin/dolphin \
            --set XDG_CONFIG_DIRS "${plasmaWorkspaceMenu}/etc/xdg:$XDG_CONFIG_DIRS" \
            --run "${kprev.kservice}/bin/kbuildsycoca6 --noincremental ${plasmaWorkspaceMenu}/etc/xdg/menus/applications.menu"
        '';
      };
    }
  );
}
